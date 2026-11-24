# EduPules — Project Audit (Implementation Status)

**Audit date:** 22 November 2026 (revised for the EduPules naming and the four-role model)
**Scope:** the connected repository folder (frontend, backend, database, docs) and the team's `System_Anlaysis.rar` package
**Rule followed:** no application source code or database file was modified. All checks ran on a separate copy.

---

## 1. Official project identity and role model

| Item | Official value | Current state of the code |
|---|---|---|
| Project name | **EduPules** — *Intelligent Academic Monitoring and Student Support System* | The interface logo, `frontend/package.json` (`edupulse-ai`) and older analysis files use the spelling "EduPulse"; some backend docstrings and the repository folder use an older working name. Rename these in the code (outside this task). |
| User roles | **Admin, Professor, Teaching Assistant (TA), Student** — exactly four | The PostgreSQL enum `user_role` still contains a **legacy fifth value**, plus a matching profile table, a foreign key from `intervention_plans` and from `students` to that table, and entries in two backend role guards. The team has decided to remove it; until then it is unused by the four official roles. |

**How the slides handle this.** All seminar material shows only the four official roles:
- Intervention management is attributed to the **TA** and the **Admin**, which matches where the interface places it: the TA menu (`/ta/interventions`) and the admin oversight page (`/admin/cmd/interventions`).
- No feature tied to the legacy role was reassigned to the Professor.
- The ER diagram shows the role profiles for students, professors and teaching assistants. It omits the legacy table and its foreign keys.

**Code changes needed to finish the alignment** (team task):
1. Drop the legacy enum value and table.
2. Re-point `intervention_plans`' owner column to `users` (or to `teaching_assistants`).
3. Remove the legacy value from `_require_staff` and the TA-dashboard guard.
4. Rename the intervention, progress and students pages shown under the TA menu.
5. Clean the sample texts in `mockData.ts`, `DeanAlerts.tsx` and the overdue-plan alert message in `analytics_extended.py`.

---

## 2. How the audit was done

| Step | What was done | Result |
|---|---|---|
| Static review | Read `backend/main.py`, all routers, `models.py`, `config.py`, `risk_model_v2.py`, `database/*.sql`, `App.tsx`, `DashboardLayout.tsx`, `AuthContext.tsx`, `lib/api.ts` and all 60 page files | Feature inventory (section 5) |
| Database build | Fresh PostgreSQL 16; ran `001_schema.sql` → `006_demo_professor_workload.sql` | All scripts ran without errors |
| Backend run | `uvicorn main:app` against that database | `/health` → healthy; DB and model `loaded v2.0.0` |
| Auth test | `POST /api/v1/auth/login` with the four demo accounts (Admin, Professor, TA, Student) | 200 for all four |
| Role tests | Student token → `/analytics/students`; Professor token → `/career-roadmap/generate` | 403 and 403 (guards work) |
| Unauthenticated tests | No token → `/ai/interventions/`, `/students/`, `/ai/assess/` | 200, 401, 500 |
| API inventory | `/openapi.json` | 77 paths, 89 operations |
| Risk engine | `POST /ai/predict` with the documented example | High, 59.0; dropout value 63.7 |
| Frontend | `npm ci`, `vite build`, `tsc -b` | Build succeeds; `tsc` reports 92 errors (89 × TS6133 unused declarations) |
| UI capture | Headless Chrome; logged in through the real form; client-side navigation | Screenshots in `Presentation_Assets/screenshots/` |
| Tests | Search outside `venv/` | None found |

---

## 3. Verified technology stack

| Layer | Technology | Evidence |
|---|---|---|
| Frontend | React ^19, TypeScript ~5.6, Vite ^6, Tailwind CSS ^4, React Router ^7, Recharts ^2.13, Framer Motion, lucide-react | `frontend/package.json` |
| Backend | Python, FastAPI 0.115.0, Uvicorn 0.32, Pydantic 2.9, pydantic-settings | `backend/requirements.txt`, `main.py` |
| Data | PostgreSQL, SQLAlchemy 2.0.36, psycopg2 | `database/001_schema.sql`, `app/db/database.py` |
| Security | bcrypt, python-jose (JWT HS256, 60-minute expiry) | `app/api/auth.py`, `app/core/config.py` |
| AI | Risk engine v2 (pure Python, rule-based); Google Gemini `gemini-2.5-flash` (REST) | `app/ai/risk_model_v2.py`, `app/api/career_roadmap.py` |
| Listed but **unused** | scikit-learn, pandas (numpy only in the unused v1 model) | no imports in active code |
| Tooling | Git (3 commits, May–Jun 2026) | `git log` |

---

## 4. Authorization for the four roles

**Server-side guards:**
- Admin only → `/api/v1/admin-panel/*` (data panel).
- Admin, Professor or TA → most `/api/v1/analytics/*` (staff analytics and alerts).
- Professor only → `/analytics/professor-dashboard`.
- TA → `/analytics/ta-dashboard`. TA, Admin or Professor → TA write endpoints (`/ta-attendance`, `/ta-grades`, `/ta-announcements`).
- Student only → `/analytics/student-dashboard`, `/career-roadmap/generate`.

**No token check:** `interventions.py`, `quizzes.py`, `risk.py`, `courses.py`, `v1/endpoints/ai.py`, `v1/endpoints/analytics.py` and the legacy `analytics.py`. They import `get_current_user` but never use it.

**Frontend:**
- `DashboardLayout` only checks that a user is logged in; routes are not restricted by role.
- Navigation menus exist for `admin`, `professor`, `ta` and `student`.

---

## 5. Feature inventory

Legend: ✅ fully implemented · 🟡 partial · 🧪 mock or placeholder · 📋 planned · ❌ documented but not implemented

| Area | Status | Evidence / notes |
|---|---|---|
| Login / JWT / role landing | ✅ | Four demo accounts return 200 |
| Registration | 🟡 | Accepts **any role**, including Admin (security issue) |
| Admin (Dean) dashboard and KPIs | ✅ | `DeanDashboard.tsx` → `/analytics/admin-overview`, `/overview` |
| Admin pages: Students, Instructors, Courses, Departments, Attendance, Exams, Analytics, Alerts, Settings | ✅ | All call `AnalyticsExtAPI`. The "AI Action Recommendations" cards in `DeanAnalytics.tsx` are hard-coded (🧪) |
| Admin pages: Admin Staff, Reports, Interventions | 🧪 | Static data |
| Admin data panel (CRUD) | ✅ | `admin_panel.py` (Admin only) |
| Early-warning alerts | ✅ | `/analytics/system-alerts`: SQL rules (Critical/High risk, GPA < 2.0, attendance < 70%); send-warning and notify-instructor create `notifications` rows |
| Risk engine v2 | 🟡 | `/ai/predict`, `/simulate`, `/batch-predict`, `/explain`, `/model-info` work but are stateless; results are not stored and not triggered by new data |
| Risk records in the DB | 🟡 | 21 seeded rows (9 Normal, 5 Low, 6 High, 1 Critical). `GET /ai/assess/` → 500 |
| Machine-learning prediction | 📋 / ❌ | No trained model or dataset. Docstrings say "calibrated" and "SHAP-style", but the weights are hand-set |
| Dropout / delay / scholarship values | 🟡 | Linear transforms of the same score; not independent predictions |
| What-if simulation UI | 🧪 | Computed in the browser or from mock data. `/ai/simulate/{id}` → 404 (the backend route is `/ai/simulate`) |
| Intervention plans | 🟡 | Backend: list, create with actions, update status. UI (`/ta/interventions`, `/admin/cmd/interventions`): local state only |
| Quizzes | 🟡 | Backend: list, get, create, submissions, analytics; no submit endpoint. UI: mock or local |
| Attendance and grade entry | 🟡 | Backend: `/analytics/ta-attendance`, `/ta-grades`. UI: mock or local |
| Professor pages (dashboard, heatmap, students, courses, TA management) | 🧪 | `mockData` / `professorMockData` |
| TA pages | 🧪 | `taMockData` or static |
| Student pages (dashboard, progress, courses, exams, inbox, documents, announcements) | 🧪 | Static or mock; the dashboard greets a hard-coded sample student |
| Student financial / payment pages | 🧪 | Static; outside the core scope |
| Career Compass (Gemini) | ✅ (code) | Student-only guard verified (403 for a Professor). The live call was not run (needs `GEMINI_API_KEY`) |
| Floating AI assistant | 🧪 | Fixed answers by keyword matching |
| Notifications | 🟡 | Endpoints exist; the UI bell is mostly static |
| University rules | 🟡 | GPA < 2.0 and attendance thresholds (80% recommended, 70% alert, "75% policy" text) are hard-coded; no NMU regulation is referenced |
| Reports / export | 🧪 | Static report pages; no export endpoint |
| Automated tests | ❌ | None |
| Deployment | 📋 | Local only |
| LMS/SIS integration, mobile app, email/SMS | 📋 | Business-canvas ideas only |

### Routed screens on live data: 13 of 51

The 51 routed pages (`App.tsx`, excluding `/auth` and `*`) are split as follows:
- TA menu: 12, including three intervention and progress pages
- Admin area: 14
- Professor: 10
- Student: 12
- Other routes: 3 (`/simulation`, `/quiz/builder`, `/admin-legacy`)

The 13 pages on live data: DeanDashboard, DeanStudents, DeanInstructors, DeanCourses, DeanDepartments, DeanAttendance, DeanExams, DeanAnalytics (partly hard-coded), DeanAlerts, DeanSettings, AdminDataPanel, AdminDashboard (`/admin-legacy`) and StudentCareerRoadmap.

---

## 6. Database

- **Tables:** 22 tables in `001_schema.sql`. This includes one legacy role-profile table that is scheduled for removal (section 1).
- **Views:** `student_risk_summary`, `course_analytics`, `at_risk_students`, `intervention_overview`, `student_engagement_summary`.
- **Materialized views:** `mv_department_analytics`, `mv_quiz_performance`.
- **Seed data:** 34 users, 8 departments, 17 courses, 21 students, 62 enrollments, 121 attendance rows, 21 risk assessments, 4 intervention plans, 4 quizzes, and 0 `grade_records`.
- **Triggers:** `updated_at`, audit, and `update_student_gpa`.
- **Older schema file:** `database/schema.sql` predates `001_schema.sql`. Treat scripts 001–006 as authoritative.

---

## 7. Defects found (backup slide C)

| Severity | Finding |
|---|---|
| High | Several routers accept requests without a JWT |
| High | Open registration with an arbitrary role |
| Medium | The API-key exemption list contains `"/"`, so every path is exempt |
| Medium | Default `DATABASE_URL` with a password is hard-coded in `config.py` |
| Medium | Reloading a dashboard while logged in crashes the app (React #310: `useCallback` after early returns in `DashboardLayout.tsx`) |
| Medium | `GET /ai/assess/` returns HTTP 500 |
| Low | Path mismatch: the frontend calls `/ai/simulate/{id}`, which returns 404 |
| Low | Login with a non-admin email while the "Login as" selector stays on Administrator first lands on `/admin/cmd` |
| Low | 92 TypeScript errors (`tsc -b` fails; the Vite build succeeds) |
| Info | Naming and legacy-role alignment is pending in code (section 1) |
| Info | `bundle.txt` and `bundle (3).md` (≈10 MB) are committed; `README.md` documents only a login fix |

---

## 8. Corrections to earlier claims

| Earlier claim | Reality |
|---|---|
| "88 API endpoints" (earlier team presentation) | 89 operations on 77 paths |
| "21 of 60 pages use sample data" | Most professor, TA and student pages use sample data; 13 of 51 routed pages are live |
| Simulation "available through POST /api/v1/ai/simulate" | The UI simulates locally; the frontend helper calls a non-existent route |
| `main.py` comment: quiz submit endpoint | Not implemented |
| "Calibrated weights based on academic research" | Hand-set constants |
| "API-key check on service routes" | Effectively disabled |

---

## 9. Missing information requiring team input

1. Full names and university IDs. Only Eyad Mostafa Algharaz (223101112) appears in the repository; the analysis folders are named اياد, وصفي and شروق. Confirm whether there is a fourth member.
2. Supervisor and assistant names, department name and seminar date.
3. Actual task ownership and status per member (slide 16 is a draft).
4. The NMU regulations to use for the GPA and attendance thresholds.
5. Whether the Business Plan (backup slide B) must be presented in the main flow.
6. The dataset for ML training in Project 2.
7. Whether to show a live Gemini demo (requires an API key).
