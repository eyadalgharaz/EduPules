# EduPules — Technical Analysis Report

**Date:** 24 November 2026
**Scope:** the connected project folder: `backend/`, `frontend/`, `database/`, `docs/`, the Git history and the earlier seminar audit (`docs/progress-seminar/Project_Audit.md`).
**Method:** I read the source code, SQL scripts, route table and role guards. I built the frontend and captured screenshots. No source or database file was changed. The runtime figures (89 API operations, the HTTP 200/401/403/500 results, the 92 TypeScript errors) come from the earlier audit, which ran the backend against a fresh PostgreSQL. I re-checked them against the code but did not run the backend again in this pass.

**Source of truth.** Where the code, the docs and the UI disagree, this report follows the code.

---

## 1. Role model and the "Advisor" naming decision

The PostgreSQL enum `user_role` has **five** values: `student`, `professor`, `advisor`, `admin`, `ta`.

| Value in the code | What exists | How the seminar presents it |
|---|---|---|
| `ta` (Teaching Assistant) | Full module. It has a `teaching_assistants` table (FK to `professors`, `departments`), `course_sections.ta_id`, 12 routed pages under `/ta/*` (including My Students, Interventions and Progress), its own sidebar, and backend endpoints `ta-full-dashboard`, `ta-sections`, `ta-announcements`, `ta-attendance`, `ta-grades` and `ta-report`. | **Presented as "Advisor".** All of this functionality appears under the Advisor name. |
| `advisor` (legacy) | An `advisors` table, `students.advisor_id` → `advisors`, `intervention_plans.advisor_id` → `advisors`, two seed users, and the value appears in the `_require_staff` and `ta-dashboard` guards. There is **no** sidebar menu: `roleNavItems` has no `advisor` key, so such a user falls back to the **admin** menu. Its old pages (`AdvisorDashboard.tsx`) are not routed. | **Omitted.** It is not shown as a role in the deck, as instructed. |

**Physical-to-logical mapping used in the diagrams.**

| Logical name in the slides | Physical name in the schema |
|---|---|
| ADVISOR entity | `teaching_assistants` |
| COURSE_SECTION.advisor_id | `course_sections.ta_id` |
| "Manage course Advisors" (Professor) | page `/professor/ta-management` (`TAManagement.tsx`) |

**Consequence for the ERD.** `intervention_plans.advisor_id` points to the legacy `advisors` table, not to `teaching_assistants`. The ERD therefore draws **no** FK between ADVISOR and INTERVENTION_PLAN. To make the code match the presentation, re-point that column (and `students.advisor_id`) to `teaching_assistants`, then remove the legacy enum value and table.

---

## 2. Features found and implementation status

Legend: ✅ working end-to-end · 🟡 partial (backend ready or partly wired) · 🧪 UI only (sample, static or local state) · 📋 planned

| Feature | Status | Evidence |
|---|---|---|
| Login, JWT and role-based landing | ✅ | `api/auth.py` (HS256, 60 min); `AuthContext.tsx` |
| Self-registration | 🟡 | `POST /auth/register` accepts any role, Admin included (security issue) |
| Admin dashboard and KPIs | ✅ | `DeanDashboard.tsx` → `/analytics/admin-overview`, `/overview` |
| Admin: Students, Instructors, Courses, Departments, Attendance, Exams, Analytics, Alerts, Settings | ✅ | `AnalyticsExtAPI`. The "AI Action Recommendations" cards in `DeanAnalytics.tsx` are hard-coded 🧪 |
| Admin: Admin Staff, Reports, Interventions pages | 🧪 | Static data |
| Admin Data Panel (generic CRUD) | ✅ | `api/admin_panel.py` (admin only) |
| Early-warning alerts | ✅ | `/analytics/system-alerts`: SQL rules for Critical/High risk, GPA drop, attendance, overdue interventions, quiz failure, inactive instructors, department risk |
| Send warning / notify instructor | 🟡 | Writes a `notifications` row for the **sender** (audit only). Nothing is delivered to the student or the instructor yet. |
| Risk Engine v2 | 🟡 | `/ai/predict`, `/simulate`, `/batch-predict`, `/explain` and `/model-info` work. They are stateless: results are not stored, and nothing triggers them when new data arrives. |
| Stored risk assessments | 🟡 | 21 seeded rows. `GET /ai/assess/` → HTTP 500 |
| Machine-learning model | 📋 | No dataset or trained model. Weights are hand-set constants, although the docstrings say "calibrated". scikit-learn and pandas are listed but not imported. |
| Dropout, delay and scholarship values | 🟡 | Linear transforms of the same score, not independent predictions |
| What-if simulator (Student) | 🧪 | Calculated in the browser (`StudentSimulation.tsx`). The helper calls `/ai/simulate/{id}` → 404 (the real route is `/ai/simulate`). |
| AI Career Compass | ✅ (code) | `career_roadmap.py` → Gemini `gemini-2.5-flash` via httpx. Student-only guard. Needs `GEMINI_API_KEY`. |
| Intervention plans | 🟡 | API: list, create with actions, change status. Advisor UI `/ta/interventions` uses local state. |
| Quizzes | 🟡 | API: list, get, create, submissions, analytics. There is no submit endpoint, although a `main.py` comment claims one. UI uses mock or local data. |
| Attendance and grade entry (Advisor) | 🟡 | `/analytics/ta-attendance` and `/ta-grades` exist, but `TAAPI` is never called by the pages. |
| Advisor pages (dashboard, sections, grading, tracking, materials, reports, schedule, students, progress) | 🧪 | `taMockData.ts` or static |
| Professor pages | 🧪 | `mockData.ts` / `professorMockData.ts`. `/analytics/professor-dashboard` exists but is unused. |
| Student pages (dashboard, progress, courses, quizzes, exams, inbox, documents, announcements) | 🧪 | Static or mock |
| Student financial and payment pages | 🧪 | Static mock-ups, outside the core scope |
| Floating AI assistant | 🧪 | Keyword-matched canned answers |
| Notifications | 🟡 | Endpoints exist; the UI bell is mostly static |
| `lib/hooks.ts` data hooks | 🧪 | Defined but used by no page |
| Automated tests | 📋 | None. pytest is listed only. |
| Deployment | 📋 | Local only |

**Screens:** 13 of the 51 routed pages use live data. They are the 10 Dean/Admin pages that call the API, plus Data Panel, `/admin-legacy` and Career Roadmap.

---

## 3. Roles and permissions (as enforced)

**Server-side guards**
- Admin only: `/api/v1/admin-panel/*`.
- Staff (`admin`, `professor`, `advisor`, `ta`): most of `/analytics/*`, including `system-alerts`, `send-warning` and `notify-instructor`.
- Professor only: `/analytics/professor-dashboard`.
- Student only: `/analytics/student-dashboard` and `/career-roadmap/generate`.
- `ta` (plus `admin`/`professor` for the write endpoints): `ta-full-dashboard`, `ta-sections`, `ta-announcements`, `ta-attendance`, `ta-grades`, `ta-report`.

**No token check.** These routers import `get_current_user` but never call it: `interventions.py`, `quizzes.py`, `risk.py`, `courses.py`, `v1/endpoints/ai.py`, `v1/endpoints/analytics.py` and the legacy `analytics.py`.

**Frontend.** `DashboardLayout` only checks that a user is logged in. Routes are not restricted by role, and any logged-in user can open any URL.

---

## 4. Technologies (verified)

| Layer | Technology | Evidence |
|---|---|---|
| Frontend | React ^19, TypeScript ~5.6, Vite ^6, Tailwind CSS ^4, React Router ^7, Recharts ^2.13, Framer Motion, lucide-react | `frontend/package.json` |
| Backend | FastAPI 0.115.0, Uvicorn 0.32, Pydantic 2.9, pydantic-settings, httpx | `backend/requirements.txt` |
| Data | PostgreSQL (SETUP asks for 15+), SQLAlchemy 2.0.36, psycopg2-binary | `database/001_schema.sql`, `app/db/database.py` |
| Security | python-jose (HS256, 60-min expiry), passlib/bcrypt | `api/auth.py`, `core/config.py` |
| AI | Risk Engine v2 (pure Python, rule-based); Google Gemini 2.5 Flash over REST | `app/ai/risk_model_v2.py`, `api/career_roadmap.py` |
| Listed but unused | numpy (used only by the unused v1 model), scikit-learn, pandas, pytest | no imports in active code |
| Tooling | Git (3 commits, May–Jun 2026), ESLint, Swagger UI at `/docs` | `git log`, `package.json` |

---

## 5. Architecture

The system is a single-page application (React) talking to **one** FastAPI service over `/api/v1` with a Bearer JWT. The Vite dev proxy forwards `/api` to port 8000.

- **Middleware:** CORS, request logging, and conversion of unhandled exceptions into JSON 500 responses.
- **Routers:** auth, analytics (legacy and extended), admin-panel, students, courses, quizzes, interventions, risk/assess, notifications, career-roadmap and ai.
- **Logic:** role guards, the risk engine, SQL alert rules and the Gemini client.
- **Data:** SQLAlchemy over PostgreSQL. The schema has 22 tables, 5 views (`student_risk_summary`, `course_analytics`, `at_risk_students`, `intervention_overview`, `student_engagement_summary`), 2 materialized views (`mv_department_analytics`, `mv_quiz_performance`), and triggers for `updated_at`, audit and GPA updates.

The only external service is Gemini. Despite the FastAPI title "EduGuard AI Microservice", this is not a microservice architecture.

**Risk Engine v2.** It computes a weighted sum of per-feature risk sub-scores:

| Feature | Weight |
|---|---|
| GPA | .28 |
| Attendance | .22 |
| Assignments | .14 |
| Quizzes | .10 |
| Activity | .09 |
| Login frequency | .06 |
| Time on platform | .05 |
| Interaction | .03 |
| Grade trend | .03 |

The score maps to a level: Normal < 25, Low < 50, High < 75, Critical ≥ 75. The output also includes per-feature contributions, an explanation, rule-based recommendations and a heuristic confidence value.

---

## 6. Inconsistencies and limitations discovered

| # | Finding | Severity |
|---|---|---|
| 1 | Two roles (`ta`, `advisor`) overlap. The legacy `advisor` has no UI menu and falls back to the admin menu. Intervention plans point to the legacy table. | High (design) |
| 2 | Seven routers accept requests without a JWT. | High |
| 3 | Open registration with any role, including Admin. | High |
| 4 | The API-key exemption list contains `"/"`, so every path is exempt and the API-key check is effectively off. | Medium |
| 5 | A default `DATABASE_URL` with a password is hard-coded in `config.py`; `backend/.env` is in the folder. | Medium |
| 6 | Reloading a dashboard while logged in gives a blank page (React error #310: hook after an early return in `DashboardLayout.tsx`). Reproduced in this pass: a hard reload on `/ta/...` rendered a blank page. | Medium |
| 7 | `GET /ai/assess/` → 500; the frontend `/ai/simulate/{id}` → 404. | Medium / Low |
| 8 | "Send warning" does not reach the student; it only records an audit notification. | Medium |
| 9 | Risk weights are described as "calibrated" and "SHAP-style" but are hand-set; there is no validation. | Medium (claims) |
| 10 | Naming: the user-facing name is **EduPules**, but the UI logo and `package.json` say "EduPulse AI", and the backend says "EduGuard AI". | Low |
| 11 | `ProfessorReports.tsx` hard-codes "Cairo University — Faculty of Engineering", while the Gemini prompt names New Mansoura University. | Low |
| 12 | 92 TypeScript errors: `tsc -b` fails, although `vite build` succeeds. | Low |
| 13 | `bundle.txt` and `bundle (3).md` (~300k lines) are committed; `README.md` documents only a login fix. | Info |
| 14 | `database/schema.sql` predates `001_schema.sql`; scripts 001–006 are authoritative. | Info |
| 15 | The guideline image lists "15–16" slides, but its own rows add up to 17–18 slides. The deck has 17 slides: the second modeling slide (sequence and class diagrams) was removed at the team's request, and its time was given to the use case slide. Speaking time is 800 s (≈ 13.3 min). | Info |

---

## 7. Team and items left as placeholders

**Team (provided by the team; shown on slides 1 and 15):**

| No. | Name | Student ID |
|---|---|---|
| 1 | Eyad Mostafa Al-Gharaz | 223101112 |
| 2 | Ahmed Hamdy Wasfy | 223101080 |
| 3 | Sara El-Sayed Soliman El-Sayed | 223101187 |
| 4 | Malak Hossam Hassan Ibrahim El-Khaboury | 223101352 |
| 5 | Roqaia Mohamed Abdelmonem Ahmed | 223101177 |
| 6 | Salma Ahmed Shawky El-Sayed | 223101191 |

**Still placeholders:**
- Supervisor name.
- Each member's responsibilities (slide 15).
- Faculty or department name. Only "New Mansoura University" appears in the code, so the slides show only that.

## 8. Related-work sources (checked 24 Nov 2026)

- EAB Navigate360 — https://eab.com/solutions/navigate360/
- Civitas Learning, Institutional Impact Platform — https://www.civitaslearning.com/platform/
- EAB Starfish — https://eab.com/solutions/starfish/

Where the reviewed page did not mention a feature, the comparison says "not described" and does not claim the feature is absent.
