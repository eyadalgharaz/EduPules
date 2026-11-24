# EduPules — Speaker Script (English)

19 slides · 800 s ≈ 13.3 min of speaking time (References not presented).

| # | Slide | Time |
|---|---|---|
| 1 | Title Slide | 20 s |
| 2 | Introduction and Project Motivation | 40 s |
| 3 | Problem Definition and Objectives | 50 s |
| 4 | Project Scope and Limitations | 40 s |
| 5 | Related Work: Local Systems | 50 s |
| 6 | Related Work: Global Systems | 50 s |
| 7 | Research Gap and Proposed Contribution | 60 s |
| 8 | Proposed Solution | 40 s |
| 9 | Functional Requirements | 45 s |
| 10 | Non-Functional Requirements | 40 s |
| 11 | Use Case Diagram | 60 s |
| 12 | System Architecture | 70 s |
| 13 | Database Design | 50 s |
| 14 | UI/UX Design | 50 s |
| 15 | Technology Selection | 35 s |
| 16 | Project Plan and Task Distribution | 35 s |
| 17 | Implementation Progress | 30 s |
| 18 | Conclusion and Next Steps | 35 s |
| 19 | References | — |

## Slide 1 — Title Slide

Good morning. We are presenting EduPules, an intelligent academic monitoring and student support system. Our team is Eyad Mostafa Al-Gharaz, Ahmed Hamdy Wasfy, Sara El-Sayed Soliman El-Sayed, Malak Hossam Hassan Ibrahim El-Khaboury, Roqaia Mohamed Abdelmonem Ahmed, and Salma Ahmed Shawky El-Sayed, [supervised by the supervisor's name]. In the next thirteen minutes we will cover the problem, related work, our solution, its design, and our progress.

## Slide 2 — Introduction and Project Motivation

EduPules is a web platform for a university faculty. It brings each student's grades, attendance, quiz results and platform activity into one database, calculates a risk level for every student, and gives administrators, professors, advisors and students their own dashboards. Our motivation is simple: today the warning signs are scattered, they are noticed late, and support is hard to coordinate. We want to move from reacting to failures to detecting risk early and acting on it together.

## Slide 3 — Problem Definition and Objectives

We identified four problems: late detection of at-risk students, fragmented academic data, uncoordinated follow-up, and limited student insight into how their grades affect their GPA and progress. Our five objectives answer these problems: one central database, an explainable risk score, automatic early-warning alerts, a focused workflow for each role, and student improvement planning with what-if simulation. The tags show which problem each objective addresses.

## Slide 4 — Project Scope and Limitations

The system serves four roles: Admin, Professor, Advisor and Student. In scope are the academic records, the risk engine, alerts, intervention plans and the student planning tools, including the planned improvement-planning workflow. Integration with the university SIS or LMS, a mobile app, email or SMS delivery, real payments and a trained ML model are outside the current scope. Current limitations: hand-set risk weights, most role screens still use sample data, some routes are not protected, and there are no automated tests.

## Slide 5 — Related Work: Local Systems

We split related work into local and global systems. Locally, we reviewed MyU at Mansoura University and Student Hub at Assiut University, using their official pages. MyU is a single student-services portal: results, online fee payment, course registration, class and exam schedules, an e-learning platform, surveys, and campus services such as meal and clinic booking. Student Hub is a gateway to academic and financial records: results for participating colleges, fees, ID and smart-card requests, admission inquiry and official forms. Both solve real administrative problems and share our goal of one place for students. Their reviewed pages do not describe performance analysis, risk assessment or academic advising; this is the space where EduPules adds academic intelligence and decision support.

## Slide 6 — Related Work: Global Systems

Globally, we reviewed EAB Navigate360 and Civitas Learning. Navigate360 is a higher-education CRM with automated alerts, cases and referrals, program advising, appointments, a reporting suite with a predictive model, AI course-planning guidance and a student app. Civitas connects institutional systems into one model, trains six institution-specific predictive models, and offers an advising CRM, degree planning and a schedule builder. These platforms already provide predictive analytics, planning and advisor collaboration, and we do not claim otherwise. EduPules is much smaller in scale; its proposed difference is one connected improvement workflow for a single faculty, built around transparent risk drivers and the faculty's own academic regulations.

## Slide 7 — Research Gap and Proposed Contribution

This slide summarises the gap. Local platforms mainly provide student services, procedures and academic information. Global platforms provide advanced student-success analytics, early alerts and advising at enterprise scale. EduPules proposes to connect, in one workflow adapted to university regulations, the following: performance analysis, explainable risk, course recommendations, a personalised improvement plan, what-if simulation, advisor approval, and progress monitoring. This is our main proposed feature: AI-Assisted Academic Improvement Planning and Simulation — moving from academic monitoring to academic improvement. The status markers are honest: risk analysis and a basic what-if simulator exist today; the improvement plan, advisor approval and plan monitoring are planned for the next phase. We do not claim that any single capability is new; the contribution is the integration.

## Slide 8 — Proposed Solution

EduPules works as one pipeline: collect data into PostgreSQL, score each student's risk with explanations, raise alerts from database rules, act through warnings and intervention plans, and guide students with simulation and planning. The lower row shows the end-to-end journey with an honest status for each step.

## Slide 9 — Functional Requirements

Here are the functional requirements by role with their status. The Admin module is the most complete and runs on live data. The Professor works with courses, quizzes, attendance, the risk heatmap and course advisors. The Advisor manages sections, records attendance and grades, tracks students and manages intervention plans; several of these have backend APIs. The Student sees a risk overview, simulates grades and generates a career roadmap with Gemini.

## Slide 10 — Non-Functional Requirements

For non-functional requirements we separate what is implemented from what is a target. Security uses bcrypt, JWT with a sixty-minute expiry and role checks; protecting every route is a target. Performance relies on indexes and analytic views. Reliability comes from database constraints and structured errors, while automated testing is still a target. We only claim what is in the code.

## Slide 11 — Use Case Diagram

This use case diagram shows the whole system. All four actors log in first. The Admin monitors the dashboard, reviews alerts — extended by sending a warning — and manages records. The Professor manages courses and quizzes, views the course risk heatmap and manages course advisors. The Advisor records attendance and grades, tracks at-risk students and manages intervention plans. The Student views their risk, simulates grades and generates a career roadmap through the external Gemini API. The heatmap and the student risk view both include the shared 'Compute risk score' use case.

## Slide 12 — System Architecture

The architecture has five layers. Users reach a React single-page application written in TypeScript. It calls one FastAPI backend over HTTP and JSON with the JWT in the Authorization header. Middleware handles CORS, logging and errors; routers delegate to the business logic: role guards, the risk engine, SQL alert rules and the Gemini client. SQLAlchemy connects to PostgreSQL. The only external service is the Gemini API. This is a single modular backend, not microservices.

## Slide 13 — Database Design

The ERD shows the core of our PostgreSQL schema. Every account is a User with a role; Student, Professor and Advisor profiles link to it. Departments own students and courses; professors teach courses and supervise advisors, who run course sections. Students relate to courses through enrolments, attendance and quiz submissions, and each student can have risk assessments and intervention plans with ordered actions. Constraints enforce one enrolment per student and course and a GPA between zero and four.

## Slide 14 — UI/UX Design

These are real screenshots of the running application, each labelled with its data source. The Admin dashboard reads live data. The Professor heatmap and Advisor screens are complete interfaces that still use sample or local data. The Career Compass is connected to the backend and Gemini, and the What-If engine calculates GPA scenarios in the browser.

## Slide 15 — Technology Selection

The frontend uses React 19 with TypeScript, Vite and Tailwind, with Recharts for charts. The backend uses FastAPI, Pydantic and SQLAlchemy, with python-jose and bcrypt for security. The database is PostgreSQL with views and triggers. The risk engine is pure Python, and career roadmaps use Gemini 2.5 Flash. Scikit-learn and pandas are reserved for the ML work in Project 2.

## Slide 16 — Project Plan and Task Distribution

This is our baseline schedule. Planning, requirements, analysis, design and the backend were delivered; the interface and integration are partial, and formal testing has not started. On the right are the six team members. [Each member states their main responsibilities.]

## Slide 17 — Implementation Progress

The database, authentication, admin analytics, the alert engine, the risk engine API and the Gemini roadmap are complete. Thirteen of fifty-one routed screens use live data, and the backend exposes eighty-nine API operations. Interventions, quizzes, attendance and notifications have APIs but unconnected screens. Remaining work includes the improvement-planning workflow, connecting all screens, security, ML, tests and deployment.

## Slide 18 — Conclusion and Next Steps

In conclusion, EduPules addresses late and uncoordinated detection of at-risk students with one integrated platform. Its proposed contribution goes one step further: from academic monitoring to academic improvement, connecting risk analysis, a personalised plan, what-if simulation, advisor approval and progress monitoring. Next, we will build that workflow, connect all role screens, harden security, train an ML model on real data, add tests and deploy. Thank you; we welcome your questions.

## Slide 19 — References

References slide; not presented in detail.
