# EduPules — Technical Appendix

This appendix explains the technical content behind the progress-seminar slides in more depth than the slides allow. Every statement is based on the repository as audited on 22 Nov 2026 (see `Project_Audit.md`). Status labels used: **Implemented**, **Partial**, **Prototype (sample data)**, **Planned**.

---

## 1. System overview

EduPules (*Intelligent Academic Monitoring and Student Support System*) is a four-role web platform. It does four things:
- centralizes academic records;
- scores each student's academic risk with an explainable engine;
- raises early-warning alerts;
- supports intervention plans.

It has three tiers: a React single-page client, a FastAPI service with an in-process risk engine, and PostgreSQL. The only external service is Google Gemini, which the backend calls for the career roadmap (Career Compass).

---

## 2. Requirements

### 2.1 Stakeholders and the four official roles

| Role (enum value) | Main responsibilities in EduPules | UI area |
|---|---|---|
| `admin` (used by the Dean) | College KPIs, departments, instructors, courses, alerts, intervention oversight, data management | `/admin/cmd/*`, `/admin/data-panel` |
| `professor` | Courses, students, course risk heatmap, quizzes, attendance, TA management, reports | `/professor/*` |
| `ta` | Sections, attendance, grading, student tracking, intervention plans, materials, schedule, reports | `/ta/*` |
| `student` | Own dashboard and risk, progress, quizzes, what-if simulation, Career Compass | `/student/*` |

Requirements were elicited through interviews with academic staff, a student-affairs officer and an IT administrator (team document "Requirement gathering"). Interviews were chosen over questionnaires because they allow follow-up questions.

### 2.2 Functional requirements (as on slide 8)

| ID | Module | The system shall… | Actor(s) | Acceptance test | Status |
|---|---|---|---|---|---|
| FR-1 | Access & administration | authenticate by email and password, return a signed JWT and route the user to the role dashboard | All | `POST /auth/login` → 200 with token; wrong password → 401 | Implemented |
| FR-2 | Access & administration | show college KPIs, department, course and instructor analytics from the database | Admin | Admin dashboard values match SQL counts | Implemented |
| FR-3 | Access & administration | list, create, update and delete records in core tables | Admin | `/admin-panel/tables/...`; non-admin → 403 | Implemented |
| FR-4 | Risk & early warning | compute risk score, level, drivers and recommendations; run a what-if simulation | Professor, Student | `POST /ai/predict`, `POST /ai/simulate` | Implemented (API) |
| FR-5 | Risk & early warning | generate alerts from database rules; send a warning as a notification | Admin | `GET /analytics/system-alerts`; send-warning inserts into `notifications` | Implemented |
| FR-6 | Teaching operations | create quizzes (time limit, attempts, shuffling, points) and report quiz analytics | Professor | `POST /ai/quizzes/`, `GET /ai/quizzes/{id}/analytics` | Partial (no submit endpoint; UI uses sample data) |
| FR-7 | Teaching operations | record attendance and grades per section | Professor, TA | `POST /analytics/ta-attendance`, `/ta-grades` | Partial (API only) |
| FR-8 | Teaching operations | create intervention plans with ordered actions and update their status | TA, Admin | `POST /ai/interventions/`, `PATCH /ai/interventions/{id}/status` | Partial (API only) |
| FR-9 | Student services | show the student's own dashboard and risk level | Student | `GET /analytics/student-dashboard` (student only) | Partial (endpoint exists; UI uses sample data) |
| FR-10 | Student services | generate career tracks, a roadmap and resources via Gemini in a fixed JSON schema | Student | `POST /career-roadmap/generate`; Professor → 403 | Implemented (live call needs API key) |

### 2.3 Non-functional requirements

| Quality | Target | Current evidence | Gap |
|---|---|---|---|
| Security | Hashed passwords; token sessions; least privilege | bcrypt (12 rounds); JWT HS256, 60 min; 403 role guards on analytics, data panel and career routes | Unguarded routers; open role registration; API-key exemption bug; JWT in localStorage |
| Reliability | No server crash on unhandled errors | Class-based middleware returns JSON 500 | No restart policy or monitoring |
| Performance | Fast dashboards on faculty-sized data | SQL views, indexes, materialized views | No load test |
| Scalability | Scale out horizontally | Stateless JWT API | Not deployed |
| Usability | Each of the four roles sees a focused menu | Role-specific navigation, colour-coded risk, dark mode | No usability study |
| Maintainability | Modular, typed code | Routers per module, Pydantic schemas, numbered SQL scripts | 92 TypeScript errors; no tests |
| Privacy | Least exposure; secrets off the client | Student routes scoped to the current user; Gemini key server-side | Unauthenticated routes expose data |
| Availability | Reachable during term | — | Local only; deployment planned |

---

## 3. Architecture (slide 12)

```
Client layer — React 19 + TypeScript SPA (Vite 6, Tailwind 4, Recharts, React Router 7; 4 role areas)
   │  HTTPS · REST /api/v1 · JSON · Authorization: Bearer <JWT>   (dev: Vite proxy /api → :8000)
   ▼
API & security layer — FastAPI service (main.py v2.1.2)
   ├─ Middleware chain: RequestLogging → APIKey → CORS
   └─ Routers: auth · analytics(+extended) · risk/ai · interventions · quizzes · notifications · admin-panel · career-roadmap
   ▼
Intelligence layer
   ├─ Risk engine v2 (app/ai/risk_model_v2.py) — in-process singleton
   ├─ Alert rules & KPIs — SQL over tables and views
   └─ Career service ──REST──► Google Gemini API (gemini-2.5-flash), key from backend/.env
   ▼
Data layer — SQLAlchemy 2 ORM + text() SQL → PostgreSQL (22 tables, 5 views, 2 materialized views)
```

**Design decisions**
- **One service instead of microservices.** The team is small and the scope is one faculty, so a single deployable is simpler. Routers keep the modules separate.
- **Raw SQL for analytics.** Aggregations (KPIs, trends, alerts) are written as SQL over views. This is clearer and faster than chained ORM queries.
- **Server-side LLM calls.** The API key stays secret, and the backend enforces the student-only rule and the JSON schema.
- **Routers mounted twice to match frontend paths.** This works, but it duplicates routes and should be consolidated.

**Security boundaries**
- **Browser ↔ API:** the JWT is checked per route on guarded routers.
- **API ↔ database:** credentials come from `.env`. A default password in `config.py` must be removed.
- **API ↔ Gemini:** the key is server-side only.

---

## 4. Risk engine v2 — risk scoring, not machine learning (backup slide A)

**Inputs:** GPA (0–4), attendance %, assignment completion %, quiz average %, platform activity score, logins per week, minutes on the platform per week, interaction level, consecutive absences, and grade trend (−1 to +1).

**Component risks (each 0–100):**
- **GPA:** a step function (≥ 3.7 → 3; ≥ 3.3 → 12; ≥ 3.0 → 22; ≥ 2.7 → 38; ≥ 2.5 → 52; ≥ 2.0 → 70; else 92).
- **Attendance:** `(100 − rate) + min(35, consecutive^1.5 × 5)`.
- **Engagement:** a weighted mix of activity, logins, time on the platform and interaction.
- **Assignments and quizzes:** `100 − value`.

**Weighted sum:** GPA 0.28, attendance 0.22, assignments 0.14, quizzes 0.10, activity 0.09, logins 0.06, time 0.05, interaction 0.03. The grade-trend weight (0.03) is declared in code, but the trend is actually applied as a separate adjustment.

**Adjustments:** `score = raw − trend × 10`, clamped to 0–100. If trend < −0.5 and the score is below 60, the score is multiplied by 1.15.

**Levels:** Normal [0, 25), Low [25, 50), High [50, 75), Critical [75, 100].

**Derived values:**
- dropout = score × 1.08 (+3 if the level is Critical)
- graduation delay = score × 0.92
- scholarship eligibility = 100 − 1.18 × score
- "confidence" is a heuristic

None of these are independent predictions.

**Why this matters.** A rule-based scorer is explainable, but its accuracy is unknown. An ML model learns weights from labelled outcomes and must be validated on held-out data (accuracy, precision, recall, ROC-AUC, calibration).

**Plan for Project 2:**
1. Obtain an approved dataset.
2. Train baseline models (logistic regression and gradient boosting).
3. Compare them with the rule-based score.
4. Keep explanations using feature contributions or SHAP.

**Example verified in the audit:** GPA 2.1, attendance 65%, assignments 55%, quizzes 58%, activity 30, 2 logins per week, 60 minutes, interaction 25, 4 consecutive absences, trend −0.3 → **High, 59.0**, dropout value 63.7. The engine recommends tutoring, better attendance and a support meeting.

---

## 5. Key workflows

### 5.1 Early warning → intervention (slide 11)

1. Grades and attendance are stored in `enrollments` and `attendances`. The `grade_records` table exists but has no seed rows.
2. A `risk_assessments` row exists for the student. In the demo these rows are seeded, and `POST /ai/assess/` can add one. *Planned:* automatic recalculation when data changes.
3. `GET /analytics/system-alerts` evaluates the rules: Critical risk, High risk, GPA < 2.0, and attendance < 70%.
4. **Admin lane:** the Admin (Dean) reviews the AI Alert Center. Choosing "send warning" or "notify instructor" inserts a row into `notifications`.
5. **TA lane:** the Teaching Assistant creates an `intervention_plans` row with ordered `intervention_actions` (via the API).
6. The plan's status moves `pending → active → completed`, and `completed_at` is set at the end.
7. The student is notified and progress is reviewed. UI integration for this step is partial.

### 5.2 Login

1. On `AuthPage`, the user signs in through `POST /auth/login`.
2. The token and user are stored in localStorage.
3. The app redirects to the role's home page.
4. `DashboardLayout` builds the role menu.

**Known defect:** a hard reload while `isInitializing` is true makes the layout return early, before a `useCallback` call. This triggers React error #310. **Fix:** move the hooks above the early returns.

### 5.3 Career Compass

1. The student completes a 3-step form.
2. The form posts to `POST /career-roadmap/generate`.
3. The backend checks the student role and calls Gemini with a career-coach prompt and a fixed JSON schema.
4. The UI renders career tracks, match scores, roadmap steps and resources.

---

## 6. Database design (slide 13)

- **Identity and roles:** `users` (role enum) has a 1 : 0..1 relationship with the profile tables `students`, `professors` and `teaching_assistants` (a TA references a professor).
- **Teaching:**
  - `courses` (professor, department)
  - `enrollments` (M:N between students and courses, `UNIQUE(student_id, course_id)`)
  - `attendances`, `grade_records`
  - `course_sections`, `announcements` (not shown on the slide)
- **Risk and action:** `risk_assessments` (history per student, with `features_snapshot` and `model_version`), `intervention_plans` → `intervention_actions`, and `notifications`.
- **Integrity:**
  - `ON DELETE CASCADE` for owned rows and `SET NULL` for optional links
  - enums for statuses and levels
  - triggers for `updated_at`, auditing and `update_student_gpa`
- **Normalization:** the core tables are in 3NF. `students.gpa` is a stored derived value that a trigger keeps up to date.
- **Omitted from the slide:** departments, course_sections, announcements, the quiz tables, logs, tokens, and the legacy role-profile table scheduled for removal (see `Project_Audit.md` §1).

---

## 7. API surface (summary)

OpenAPI lists 77 paths and 89 operations.

| Prefix | Purpose | Auth |
|---|---|---|
| `/api/v1/auth` | login, me, logout, register | login and register are public; `me` needs a JWT |
| `/api/v1/analytics` | 34 extended endpoints (KPIs, students, courses, risk, alerts, notifications, role dashboards, TA writes), plus 10 v1 and 3 legacy endpoints | mostly staff JWT (Admin, Professor, TA); the v1 and legacy endpoints are unguarded |
| `/api/v1/ai` | predict, simulate, batch-predict, explain, model-info | **unguarded** |
| `/api/v1/ai/quizzes`, `/ai/interventions`, `/ai/assess`, `/ai/notifications` | module routers | mostly **unguarded** (notifications needs a JWT) |
| `/api/v1/admin-panel` | generic table CRUD | Admin JWT |
| `/api/v1/students`, `/courses` | list, get, create | students: JWT; courses: unguarded |
| `/api/v1/career-roadmap/generate` | Gemini roadmap | Student JWT |
| `/health` | DB and model health | public |

---

## 8. Diagrams

| Diagram | Slide | Form | Source |
|---|---|---|---|
| Concept pipeline (6 stages) | 7 | native PowerPoint shapes | `Diagrams/concept_pipeline.mmd` |
| Use case (4 actors + Gemini) | 10 | image | `Diagrams/use_case.dot` |
| Activity: early warning → intervention (System / Admin / TA lanes) | 11 | native shapes | `Diagrams/activity_early_warning_to_intervention.mmd` |
| Layered architecture | 12 | native shapes | `Diagrams/system_architecture.mmd` |
| ER diagram (12 core tables) | 13 | native shapes | `Diagrams/er_diagram.dot` (Graphviz alternative) |
| Gantt (baseline plan) | 16 | native shapes | `Diagrams/gantt_baseline_plan.mmd` |

The team archive also contains earlier diagrams drawn under an earlier spelling of the name (class diagram, risk-lifecycle state machine, sequence and activity diagrams, 4+1 views). Update them to the EduPules name and the four-role model before reusing them in the documentation.

---

## 9. Presentation design decisions

- **Visual identity:**
  - deep navy (#101C35) and midnight blue (#172B4D) for high-impact slides (cover, problem, solution, conclusion)
  - white and soft-grey (#F5F7FB) for content slides
  - royal blue (#4169E1) and teal (#20B8A8) as accents
  - status colours: green (working), amber (partial), red (not started)
- **Motif:** a teal "pulse" line, which echoes the EduPules name, plus the pulse logo mark in every footer.
- **Typography:** the theme fonts are Aptos Display for headings and Aptos for body text. Aptos ships with Microsoft 365. If a machine lacks it, change the theme fonts once in PowerPoint (Design → Variants → Fonts).
- **Font sizes:** titles are 30 pt and key statements 18–36 pt. Diagram labels and dense tables use 11–14 pt so the 18 timed slides fit 13–14 minutes. The guideline asks for at least 24 pt "where practical".
- **Honesty markers:** "Working", "Partial", "Prototype" and "Live data" chips appear wherever functionality is shown.
- **Screenshots:** real captures shown in browser frames, cropped without distortion. Screens whose sample text uses the legacy role name were not used.
