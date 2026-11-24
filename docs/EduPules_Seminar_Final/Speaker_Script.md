# EduPules — Presentation Script / Speaker Notes

Progress Seminar · 17 slides · about 13 min 20 s of speaking time (References not presented). The same text is in each slide's speaker notes in the .pptx.

**Team:** Eyad Mostafa Al-Gharaz (223101112) · Ahmed Hamdy Wasfy (223101080) · Sara El-Sayed Soliman El-Sayed (223101187) · Malak Hossam Hassan Ibrahim El-Khaboury (223101352) · Roqaia Mohamed Abdelmonem Ahmed (223101177) · Salma Ahmed Shawky El-Sayed (223101191)

| # | Slide | Time |
|---|---|---|
| 1 | Title Slide | 20 s |
| 2 | Introduction and Project Motivation | 40 s |
| 3 | Problem Definition and Objectives | 60 s |
| 4 | Project Scope and Limitations | 40 s |
| 5 | Related Work and Existing Solutions | 60 s |
| 6 | Proposed Solution | 50 s |
| 7 | Functional Requirements | 50 s |
| 8 | Non-Functional Requirements | 50 s |
| 9 | General Use Case Diagram | 90 s |
| 10 | System Architecture and Design | 80 s |
| 11 | Database Design | 60 s |
| 12 | UI/UX Design | 60 s |
| 13 | Technology Selection | 40 s |
| 14 | Project Plan and Task Distribution | 40 s |
| 15 | Implementation Progress | 30 s |
| 16 | Conclusion and Next Steps | 30 s |
| 17 | References | — |
| | **Total** | **800 s ≈ 13.3 min** |

Text in [square brackets] is for the team to fill in (supervisor, responsibilities). Assign a speaker to each slide before the rehearsal.

## Slide 1 — Title Slide  (20 s)

Good morning. We are presenting EduPules, an intelligent academic monitoring and student support system. Our team is Eyad Mostafa Al-Gharaz, Ahmed Hamdy Wasfy, Sara El-Sayed Soliman El-Sayed, Malak Hossam Hassan Ibrahim El-Khaboury, Roqaia Mohamed Abdelmonem Ahmed, and Salma Ahmed Shawky El-Sayed, [supervised by the supervisor's name]. In the next thirteen minutes we will cover the problem, our solution, its design, and how far the implementation has come.

## Slide 2 — Introduction and Project Motivation  (40 s)

EduPules is a web platform for a university faculty. It brings each student's grades, attendance, quiz results and platform activity into one database, calculates a risk level for every student, and gives administrators, professors, advisors and students their own dashboards. Our motivation is simple: today the warning signs are scattered, they are noticed late, and support is hard to coordinate. We want staff to move from reacting to failures to detecting risk early and acting on it together.

## Slide 3 — Problem Definition and Objectives  (60 s)

We identified four problems. First, at-risk students are detected late, usually after poor exam results. Second, the data needed to see the risk is fragmented. Third, warnings and follow-up actions are not recorded in one shared place. Fourth, students cannot easily see how their current grades affect their GPA, their risk, or their career direction. Our five objectives answer these problems: one central database, an explainable risk score, automatic early-warning alerts, a focused workflow for each of the four roles, and self-service planning tools for students. The tags on the right show which problem each objective addresses.

## Slide 4 — Project Scope and Limitations  (40 s)

The system serves four roles: Admin, Professor, Advisor and Student. In scope are the academic records, the risk engine, alerts, intervention plans, and the student planning tools. Integration with the university's student information system or LMS, a mobile app, email or SMS delivery, real payments, and a trained machine-learning model are outside the current scope. We are also clear about current limitations: the risk weights are set by hand and not yet validated, most professor, advisor and student screens still show sample data, some API routes are not protected yet, and there are no automated tests.

## Slide 5 — Related Work and Existing Solutions  (60 s)

We compared three established platforms using their official product pages. EAB Navigate360 is a higher-education CRM with alerts, predictive models, case management and a student app. Civitas Learning unifies institutional data and offers institution-tailored predictive models, alerts and an advising CRM. EAB Starfish focuses on early alerts, case management, analytics and degree planning. All three share our goal of early identification and support. They differ from EduPules in scale and approach: they are commercial, institution-wide products built on integrations with existing systems. Where a cell says 'not described', the feature was simply not mentioned on the page we reviewed; we do not claim it is missing. The gap we target is a lightweight, self-contained platform for one faculty, with a risk formula staff can inspect, one workflow for four roles, and student self-service in the same system.

## Slide 6 — Proposed Solution  (50 s)

EduPules works as one pipeline. Data is collected into PostgreSQL. The risk engine converts each student's indicators into a score from zero to one hundred and a level: Normal, Low, High or Critical, with the main drivers and recommendations. Database rules then raise alerts, for example for critical risk, GPA drops or attendance below seventy percent. Staff act on those alerts through warnings and intervention plans, and students use the simulator and the AI career roadmap. The lower row shows the end-to-end journey, with an honest status for each step: alerts are live, while the advisor and student screens are still being connected to the backend.

## Slide 7 — Functional Requirements  (50 s)

Here are the functional requirements grouped by role, with the status of each one. The Admin has the most complete module: institutional dashboards, analytics, alerts and a data panel are all connected to the live database. The Professor works with courses, quizzes, attendance, the course risk heatmap and the course advisors. The Advisor manages lab sections, records attendance and grades, tracks below-average students and manages intervention plans; several of these already have backend endpoints. The Student sees a risk overview, simulates grades and generates a career roadmap with Gemini. The legend shows which requirements are working end to end, which have a ready API, and which are still interface prototypes.

## Slide 8 — Non-Functional Requirements  (50 s)

For non-functional requirements we separate what is already implemented from what is still a target. Security already uses bcrypt password hashing, JWT tokens with a sixty-minute expiry, and role checks on the admin, analytics and career routes; the target is to protect every router and stop users from registering themselves as Admin. Performance relies on indexes and analytic views. Reliability comes from database constraints and structured error responses, but automated testing is still a target. Usability, maintainability, scalability and availability follow the same pattern: we only claim what is in the code, and the rest is listed as a goal.

## Slide 9 — General Use Case Diagram  (90 s)

This use case diagram shows the whole system. All four actors log in first. The Admin monitors the institution dashboard, reviews early-warning alerts, and can extend that review by sending a warning or notifying an instructor; the Admin also manages records through the data panel. The Professor manages courses and quizzes, views the course risk heatmap, and manages the advisors assigned to the course. The Advisor records attendance and grades, tracks at-risk students and manages intervention plans. The Student views their risk assessment, simulates grades, and generates a career roadmap, which uses the external Gemini API. Both the heatmap and the student risk view include the shared 'Compute risk score' use case. This diagram is our main analysis model: it shows every role's interactions with the system in one view.

## Slide 10 — System Architecture and Design  (80 s)

The architecture has five layers. Users of the four roles reach a React single-page application written in TypeScript. The application calls one FastAPI backend over HTTP and JSON, sending the JWT in the Authorization header. Inside the backend, middleware handles CORS, logging and error handling, and the routers delegate to the business logic: authentication and role guards, the risk engine, the SQL alert rules and the Gemini client. SQLAlchemy connects to PostgreSQL, which holds the tables, the analytic views and the triggers. The only external service is the Google Gemini API, used for career roadmaps. Note that this is a single modular backend, not a set of microservices.

## Slide 11 — Database Design  (60 s)

The ERD shows the core of our PostgreSQL schema. Every account is a User with a role; Student, Professor and Advisor profiles link to it one-to-one. Departments own students and courses. Professors teach courses and supervise advisors, and advisors run course sections. Students relate to courses through enrollments, attendance and quiz submissions. Each student can have many risk assessments and intervention plans, and each plan has ordered actions. Database rules enforce one enrollment per student and course, one attendance record per student, course and day, and a GPA between zero and four. A trigger recalculates the GPA automatically.

## Slide 12 — UI/UX Design  (60 s)

These are real screenshots of the running application. The Admin dashboard reads live data: the risk distribution comes directly from the database. The Professor's risk heatmap, the Advisor dashboard and the Advisor's intervention board are complete interfaces that still use sample or local data. The student's AI Career Compass is connected to the backend and Gemini, and the What-If engine calculates GPA scenarios in the browser. Each screenshot is labelled with its data source so the status is clear.

## Slide 13 — Technology Selection  (40 s)

The frontend uses React 19 with TypeScript, built with Vite and styled with Tailwind CSS, with Recharts for charts. The backend uses FastAPI and Pydantic, SQLAlchemy as the ORM, and python-jose and bcrypt for security. The database is PostgreSQL, using views, materialized views and triggers. For AI, the risk engine is written in pure Python, and career roadmaps use Google Gemini 2.5 Flash. Scikit-learn and pandas are already listed in our requirements for the machine-learning work planned in Project 2.

## Slide 14 — Project Plan and Task Distribution  (40 s)

This is our baseline schedule from the project plan. Planning, requirements, analysis, system and database design, and the backend were delivered. The user interface and integration are partially complete, and formal testing has not started, so these tasks continue into the next phase. On the right are the six team members. [Each member states their main responsibilities.]

## Slide 15 — Implementation Progress  (30 s)

To summarise progress: the database, authentication, admin analytics, the alert engine, the risk engine API and the Gemini career roadmap are complete. Thirteen of the fifty-one routed screens already use live data, and the backend exposes eighty-nine API operations. Intervention plans, quizzes, attendance and grade entry, and notifications have working APIs but their screens are not connected yet. The remaining work is to connect the remaining screens, secure all routes, train and validate a machine-learning model, add tests, and deploy.

## Slide 16 — Conclusion and Next Steps  (30 s)

In conclusion, EduPules addresses late and uncoordinated detection of at-risk students with one integrated platform: a central database, an explainable risk score, automatic alerts and role-based workflows. Its contribution is a lightweight, transparent alternative to large commercial platforms, built for a single faculty. In the next phase we will connect all role screens to the API, harden security, train a machine-learning model on real data, add automated tests and deploy the system. Thank you; we welcome your questions.

## Slide 17 — References  (not presented)

References slide; not presented in detail.
