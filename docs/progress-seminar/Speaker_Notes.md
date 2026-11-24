# EduPules — Speaker Notes and Presentation Script

Graduation Project 1 — Progress Seminar (NMU-CSE).

**Planned speaking time:** 830 s ≈ 13.8 minutes for slides 1–18 (references and backup slides A–C are not timed).

**How to use this file**
- Each slide has: the main message, a short English script (about 100–150 words per minute), a separate Arabic explanation for the team, and likely committee questions with suggested answers.
- The English script is also in the PowerPoint speaker notes; the Arabic explanation and Q&A are only here.
- `[Member N]` speaker assignments are placeholders. The NMU-CSE guideline asks for equal participation: split sections by strengths and rehearse the hand-overs (for example, "Now my teammate [Name] will explain the system architecture.").
- EduPules has exactly four roles: Admin, Professor, Teaching Assistant and Student. Use these names consistently when answering questions.
- Explain, do not read. Every number on the slides was verified during the repository audit (`Project_Audit.md`).

| # | Slide | Time | Speaker |
|---|---|---|---|
| 1 | Title | 20 s | [Member 1] |
| 2 | Introduction and Motivation | 40 s | [Member 1] |
| 3 | Problem Definition | 30 s | [Member 1] |
| 4 | Project Objectives | 30 s | [Member 1] |
| 5 | Project Scope and Limitations | 40 s | [Member 2] |
| 6 | Related Work | 60 s | [Member 2] |
| 7 | Proposed Solution | 50 s | [Member 2] |
| 8 | Functional Requirements | 50 s | [Member 3] |
| 9 | Non-Functional Requirements and Roles | 50 s | [Member 3] |
| 10 | Use Case Diagram | 60 s | [Member 4] |
| 11 | Workflow: Early Warning to Intervention | 60 s | [Member 4] |
| 12 | System Architecture | 80 s | [Member 4] |
| 13 | Database Design | 60 s | [Member 3] |
| 14 | UI/UX Design | 60 s | [Member 2] |
| 15 | Technology Selection | 40 s | [Member 3] |
| 16 | Project Plan and Task Distribution | 40 s | [Member 1] |
| 17 | Implementation Progress | 30 s | [Member 1] |
| 18 | Conclusion and Next Steps | 30 s | [Member 1] |
| 19 | References | — | — |
| Backup A | Backup A: Risk Scoring vs Machine Learning | — | Backup |
| Backup B | Backup B: Business Model | — | Backup |
| Backup C | Backup C: Audit Findings | — | Backup |
| | **Total** | **830 s (13.8 min)** | |

---

## Slide 1 — Title

**Time:** 20 seconds  ·  **Speaker:** [Member 1]

**Main message:** Introduce EduPules, the team and the supervisor.

### English script

Good morning. We present EduPules, an intelligent academic monitoring and student support system. I am [name], with [teammates], supervised by [supervisor]. We will cover the problem, our solution, its design, and the progress we have made so far.

### Arabic explanation (for the team)

<div dir="rtl">

شريحة العنوان. نعرّف بالمشروع: EduPules نظام ذكي لمتابعة الأداء الأكاديمي ودعم الطلاب؛ يجمع بيانات الطالب، ويكتشف مؤشرات التعثر مبكراً، ويساعد الطاقم على التدخل. يتم تقديم أعضاء الفريق والمشرف. أسماء باقي الأعضاء وأرقامهم واسم المشرف والتاريخ غير موجودة في المستودع، لذلك تُركت كحقول بين أقواس يجب تعبئتها قبل العرض.

</div>

### Expected committee questions

**Q:** Why does the interface show a slightly different spelling of the name?  
**A:** EduPules is the official project name. The current build still shows an earlier spelling in its logo; aligning the interface text is a small task scheduled before the final submission.

---

## Slide 2 — Introduction and Motivation

**Time:** 40 seconds  ·  **Speaker:** [Member 1]

**Main message:** Universities already hold the signals of academic risk; the problem is that they are seen too late.

### English script

Our domain is student success in higher education. Universities already record grades, attendance and online activity, but these records sit in separate places and are usually reviewed after exams. In our requirement interviews, academic staff told us that struggling students are often noticed only after results are published, when help comes too late. That gap motivated EduPules: bring the signals together, flag risk early, and help staff act. EduPules serves four user roles: administrators, professors, teaching assistants and students.

### Arabic explanation (for the team)

<div dir="rtl">

المجال هو نجاح الطالب في التعليم الجامعي. الجامعة تسجل الدرجات والحضور والنشاط الإلكتروني، لكن هذه البيانات متفرقة ويتم مراجعتها غالباً بعد الامتحانات. في مقابلات جمع المتطلبات ذكر أعضاء الطاقم الأكاديمي أن الطالب المتعثر يُكتشف عادة بعد ظهور النتائج، أي بعد فوات الأوان. هذا هو الدافع لـ EduPules: تجميع المؤشرات، والتنبيه المبكر، ومساعدة الطاقم على التدخل. النظام يخدم أربعة أدوار فقط: الإدارة، الأستاذ، المعيد، والطالب.

</div>

### Expected committee questions

**Q:** Who did you interview?  
**A:** Academic staff, a student-affairs officer and an IT administrator, as recorded in our requirement-gathering document. It was a small qualitative study, so we do not present it as statistics.

**Q:** Do you have dropout statistics for NMU?  
**A:** No. We have not obtained verified institutional data, so we deliberately quote no statistics. This is listed as a limitation.

---

## Slide 3 — Problem Definition

**Time:** 30 seconds  ·  **Speaker:** [Member 1]

**Main message:** Risk detection today is fragmented, late, unexplained and untracked.

### English script

We define the problem in four parts. Data is fragmented across systems. Detection is late, usually after final results. A bare number does not tell staff what to fix first. And interventions are tracked informally, so follow-up is lost. The consequence is that support arrives after a student has already failed or withdrawn.

### Arabic explanation (for the team)

<div dir="rtl">

المشكلة من أربعة أجزاء: (1) تشتت البيانات بين أنظمة مختلفة، (2) الاكتشاف المتأخر بعد النتائج النهائية، (3) غياب التفسير: رقم الخطر وحده لا يوضح ماذا يجب علاجه أولاً، (4) عدم توثيق التدخلات ومتابعتها. النتيجة: الدعم يصل بعد أن يرسب الطالب أو ينسحب. لم نستخدم أي إحصائيات غير موثقة.

</div>

### Expected committee questions

**Q:** How do you know detection is late?  
**A:** From our stakeholder interviews and from the way current processes work: results are reviewed at the end of the term. We do not claim a measured delay.

---

## Slide 4 — Project Objectives

**Time:** 30 seconds  ·  **Speaker:** [Member 1]

**Main message:** Six objectives that map directly onto the four problem areas.

### English script

Our objectives answer those problems directly. We centralize academic data in one relational database. We monitor performance through role-specific dashboards. We score academic risk with an explainable model. We raise early warnings from defined indicators. We support structured intervention plans, and we give academic leaders data for decisions.

### Arabic explanation (for the team)

<div dir="rtl">

الأهداف الستة مرتبطة مباشرة بالمشكلة: مركزية البيانات في قاعدة بيانات واحدة، لوحات متابعة لكل دور، تقييم خطر قابل للتفسير، تنبيهات مبكرة من مؤشرات محددة، خطط تدخل منظمة، ودعم اتخاذ القرار للقيادات الأكاديمية.

</div>

### Expected committee questions

**Q:** How will you measure whether you met these objectives?  
**A:** In Project 1 we verify functionally, feature by feature. In Project 2 we plan measurable checks: model accuracy on held-out data and how early alerts fire compared with final results.

---

## Slide 5 — Project Scope and Limitations

**Time:** 40 seconds  ·  **Speaker:** [Member 2]

**Main message:** We separate what we chose to exclude from what constrains us.

### English script

In scope is a four-role web platform with centralized data, explainable risk scoring with what-if simulation, rule-based early warnings, intervention plans, quizzes, analytics and an AI career roadmap. Out of scope, by choice, are replacing the university's student information system or LMS, real payments, native mobile apps and automated decisions about students. Our limitations are different: we have no real institutional data yet, risk weights are hand-set rather than trained, development time is limited, and privacy rules restrict the data we can use.

### Arabic explanation (for the team)

<div dir="rtl">

داخل النطاق: منصة ويب بأربعة أدوار، تجميع البيانات، تقييم خطر قابل للتفسير مع محاكاة ماذا-لو، تنبيهات مبكرة قائمة على قواعد، خطط تدخل، اختبارات قصيرة، تحليلات، وخارطة طريق مهنية بالذكاء الاصطناعي. خارج النطاق (اختيار مقصود): استبدال نظام معلومات الطلاب أو الـ LMS، المدفوعات الحقيقية، تطبيق الموبايل، والقرارات التلقائية عن الطالب. القيود (ليست اختياراً): لا توجد بيانات حقيقية بعد، الأوزان محددة يدوياً وغير مدربة، الوقت محدود، وقيود الخصوصية.

</div>

### Expected committee questions

**Q:** The interface has financial and payment pages. Are they in scope?  
**A:** No. They are static interface prototypes with no backend and will be removed or clearly labelled.

**Q:** Why not integrate with the LMS now?  
**A:** It requires institutional access and approval that we do not have in Project 1. The relational design allows an import or connector later.

---

## Slide 6 — Related Work

**Time:** 60 seconds  ·  **Speaker:** [Member 2]

**Main message:** Established platforms already do this at enterprise scale; EduPules is a transparent, faculty-scale prototype, not a competitor.

### English script

We compared three commercial platforms and one peer-reviewed framework. Civitas Learning unifies institutional data and provides institution-specific predictive models and alerts. EAB Navigate360 is a student-success CRM with early alerts, predictive analytics and case management. EAB Starfish focuses on early alerts, scheduling, case management and degree planning. The SPPA framework by Alalawi and colleagues builds course-level prediction models and runs interventions; it reported significant gains in some courses but not in others, and noted barriers such as manual data uploads. EduPules shares the same pipeline idea. Our contribution is scope and transparency for a single faculty. We make no claim to outperform these systems.

### Arabic explanation (for the team)

<div dir="rtl">

قارنّا ثلاث منصات تجارية وإطاراً بحثياً محكّماً. Civitas Learning يوحّد بيانات المؤسسة ويقدم نماذج تنبؤ خاصة بها وتنبيهات. EAB Navigate360 نظام CRM لنجاح الطالب فيه تنبيهات مبكرة وتحليلات تنبؤية وإدارة حالات. EAB Starfish يركز على التنبيهات المبكرة والجدولة وإدارة الحالات وتخطيط المسار الدراسي. إطار SPPA (مجلة IJAIED) يبني نماذج تنبؤ على مستوى المقرر ويطبق تدخلات؛ أظهر تحسناً ذا دلالة في بعض المقررات فقط، وذكر عوائق مثل رفع البيانات يدوياً. EduPules يشترك معهم في الفكرة؛ الإضافة هي الشفافية والملاءمة لكلية واحدة. لا ندّعي التفوق عليهم.

</div>

### Expected committee questions

**Q:** Why build EduPules if these products exist?  
**A:** They are enterprise products that require institution-wide integration and licensing. As a graduation project we build a transparent prototype to study the full pipeline and adapt it to local rules.

**Q:** What exactly did the SPPA paper find?  
**A:** Statistically significant gains in some courses only; other courses showed no significant change. Prediction was possible only after the first assessment, and manual uploads hindered adoption.

---

## Slide 7 — Proposed Solution

**Time:** 50 seconds  ·  **Speaker:** [Member 2]

**Main message:** EduPules turns academic data into early warnings and tracked interventions through one six-stage pipeline.

### English script

EduPules follows one pipeline. Academic data is stored in PostgreSQL. Analytics turns it into KPIs and trends for each role. Risk assessment scores each student from zero to one hundred with an explainable engine. Early warning converts critical risk, low GPA and low attendance into alerts. Staff then create intervention plans with ordered actions, and monitoring tracks their status. The status line shows reality: the first four stages work end to end; intervention and monitoring exist in the API but their screens still use sample data. Our distinguishing contribution is explainability: every score comes with its drivers, recommendations and a what-if simulation.

### Arabic explanation (for the team)

<div dir="rtl">

الحل خط معالجة من ست مراحل: البيانات الأكاديمية في PostgreSQL، التحليلات لكل دور، تقييم الخطر من 0 إلى 100 بمحرك قابل للتفسير، التنبيه المبكر عند الخطر الحرج أو انخفاض المعدل أو الحضور، التدخل عبر خطط بخطوات مرتبة، ثم المتابعة. سطر الحالة يوضح الواقع: أول أربع مراحل تعمل فعلياً، والتدخل والمتابعة موجودان في الـ API لكن شاشاتهما ما زالت ببيانات تجريبية. الإضافة المميزة هي التفسير: كل درجة معها أسبابها وتوصيات ومحاكاة ماذا-لو.

</div>

### Expected committee questions

**Q:** Is the risk score updated automatically when a grade changes?  
**A:** Not yet. The engine is a stateless API and the demo risk records are seeded. Automatic recalculation is a next milestone.

---

## Slide 8 — Functional Requirements

**Time:** 50 seconds  ·  **Speaker:** [Member 3]

**Main message:** Ten testable functional requirements grouped into four modules, each with its verified status.

### English script

We grouped ten testable functional requirements into four modules. Access and administration: sign-in with a signed token and a role landing page, college analytics, and record management for the admin. Risk and early warning: an explainable score with what-if simulation, and alerts that the admin can turn into warnings. Teaching operations: quizzes, attendance and grades, and intervention plans for professors and teaching assistants. Student services: the student dashboard and the career roadmap through Gemini. Green means implemented end to end; amber means the backend exists but the screen is not yet connected.

### Arabic explanation (for the team)

<div dir="rtl">

عشرة متطلبات وظيفية قابلة للاختبار في أربع وحدات: (1) الدخول والإدارة: تسجيل الدخول بـ JWT، توجيه كل دور للوحته، وإدارة السجلات للمدير. (2) الخطر والتنبيه المبكر: درجة قابلة للتفسير مع محاكاة ماذا-لو، وتنبيهات يحوّلها المدير إلى تحذيرات. (3) العمليات التعليمية: الاختبارات، الحضور والدرجات، وخطط التدخل للأستاذ والمعيد. (4) خدمات الطالب: لوحة الطالب (ما زالت نموذجاً أولياً) وخارطة الطريق عبر Gemini. النقطة الخضراء = مكتمل، البرتقالية = موجود في الخادم والشاشة غير مربوطة بعد.

</div>

### Expected committee questions

**Q:** Which requirement is weakest right now?  
**A:** Teaching operations: the quiz, attendance and intervention endpoints exist, but the professor and TA screens still use sample data.

---

## Slide 9 — Non-Functional Requirements and Roles

**Time:** 50 seconds  ·  **Speaker:** [Member 3]

**Main message:** Quality targets are stated with current evidence, and the matrix shows what the server enforces for the four roles.

### English script

For security we use bcrypt hashing and signed JWT tokens with a sixty-minute expiry, and we verified that a student receives 403 on staff analytics. Reliability comes from middleware that turns crashes into JSON errors; maintainability from layered FastAPI routers with typed schemas; usability from role-specific navigation. Performance relies on SQL views, but we have not load-tested. The matrix shows the four official roles: Admin, Professor, Teaching Assistant and Student. Our audit also found routes that do not yet check the token; closing that gap is our first security task.

### Arabic explanation (for the team)

<div dir="rtl">

الأمان: تشفير كلمات المرور bcrypt ورموز JWT موقعة صلاحيتها 60 دقيقة، وتحققنا أن الطالب يحصل على 403 عند طلب تحليلات الطاقم. الاعتمادية: Middleware يحوّل الأعطال إلى رد JSON. الصيانة: Routers منفصلة وأنواع Pydantic. سهولة الاستخدام: قوائم حسب الدور. الأداء: SQL Views، ولم نجرِ اختبار حمل بعد. المصفوفة تعرض الأدوار الأربعة الرسمية فقط: المدير، الأستاذ، المعيد، الطالب. وجدنا مسارات لا تتحقق من الـ token وهذه أول مهمة أمنية.

</div>

### Expected committee questions

**Q:** Is the system secure enough for real data?  
**A:** Not yet. Authentication and several role checks work, but some routes are unauthenticated and registration accepts any role. These must be fixed, plus HTTPS deployment, before real data is used.

**Q:** Where is the Dean?  
**A:** The Dean uses the Admin role; the admin area is presented as a command center. There is no separate dean role.

---

## Slide 10 — Use Case Diagram

**Time:** 60 seconds  ·  **Speaker:** [Member 4]

**Main message:** Four actors and one external system; the diagram is derived from the real routes and role checks.

### English script

This use case diagram is derived from the application routes and backend role checks. On the left, the student views their risk dashboard, runs what-if simulations, takes quizzes and generates a career roadmap, which uses Google Gemini as an external system. The professor builds quizzes, views the course risk heatmap and records attendance and grades. On the right, the admin monitors college KPIs, reviews early-warning alerts, oversees interventions and manages records. The teaching assistant records attendance and grades, tracks students and manages intervention plans. Every use case includes logging in; we show that relation once for readability.

### Arabic explanation (for the team)

<div dir="rtl">

مخطط حالات الاستخدام مستخرج من مسارات الواجهة والتحقق من الأدوار في الخادم، وفيه أربعة ممثلين فقط. الطالب: لوحة الخطر، محاكاة ماذا-لو، حل الاختبارات، وخارطة الطريق المهنية التي تستخدم Google Gemini كنظام خارجي. الأستاذ: إنشاء الاختبارات، خريطة الخطر للمقرر، تسجيل الحضور والدرجات. المدير: مؤشرات الكلية، مراجعة التنبيهات وإرسال التحذير، الإشراف على التدخلات، وإدارة السجلات. المعيد: الحضور والدرجات، متابعة الطلاب، وإدارة خطط التدخل. كل حالة تتضمن تسجيل الدخول (include) وعرضناها مرة واحدة.

</div>

### Expected committee questions

**Q:** Why is Gemini on the diagram?  
**A:** It is an external system that participates in the career-roadmap use case, so UML places it outside the system boundary.

**Q:** Who manages interventions?  
**A:** In the implemented interface, intervention management sits in the Teaching Assistant area, and the Admin has an oversight page. We assign it to those two roles only.

---

## Slide 11 — Workflow: Early Warning to Intervention

**Time:** 60 seconds  ·  **Speaker:** [Member 4]

**Main message:** The core workflow runs from academic data to a risk record, an alert, a warning and a tracked intervention.

### English script

This activity diagram shows our main workflow in three swimlanes. In the system lane, grades and attendance are stored, a risk record exists for each student, and alert rules check for critical or high risk, GPA below 2.0 and attendance below 70 percent. In the admin lane, the dean reviews the alert center and decides whether to act; sending a warning creates a notification. In the teaching assistant lane, an intervention plan is created with ordered actions, its status moves from pending to active to completed, and the student is notified. Two points matter: alert rules are deterministic, not machine learning, and automatic risk recalculation is still to be built.

### Arabic explanation (for the team)

<div dir="rtl">

مخطط النشاط بثلاث مسارات: (النظام) تخزين الدرجات والحضور، وجود سجل خطر لكل طالب، ثم قواعد التنبيه تفحص: خطر حرج أو مرتفع، معدل أقل من 2.0، حضور أقل من 70%. (المدير/العميد) مراجعة مركز التنبيهات واتخاذ القرار؛ إرسال التحذير ينشئ إشعاراً. (المعيد) إنشاء خطة تدخل بخطوات مرتبة، تتغير حالتها pending ثم active ثم completed، ويُخطر الطالب. مهم: قواعد التنبيه حتمية وليست تعلم آلة، والحساب التلقائي للخطر لم يُبنَ بعد.

</div>

### Expected committee questions

**Q:** Does the system decide that an intervention is needed?  
**A:** No. The system raises alerts and recommendations; a person decides and creates the plan. We keep a human in the loop on purpose.

**Q:** Where do 2.0 and 70% come from?  
**A:** They are coded in the alert service. 2.0 matches a common probation GPA; both must be confirmed against NMU regulations.

---

## Slide 12 — System Architecture

**Time:** 80 seconds  ·  **Speaker:** [Member 4]

**Main message:** A layered client-server design: React client, FastAPI service with an in-process risk engine, PostgreSQL, and Gemini reached only from the server.

### English script

EduPules uses a layered client-server architecture. The client layer is a React 19 and TypeScript single-page application with role-based layouts and charts. It talks to the server only through REST with JSON and a bearer token. In the service, every request first passes middleware for logging, an API-key check and CORS. Routers then handle authentication, analytics, risk, quizzes, interventions, notifications, the admin data panel and the career roadmap. The intelligence layer contains the risk engine, which runs in the same Python process, and the SQL alert rules. Google Gemini is the only external service and is called from the server, so its key never reaches the browser. The data layer is PostgreSQL with twenty-two tables, five views and two materialized views, accessed through SQLAlchemy and SQL. The security boundary is the API, where the JWT is checked per route.

### Arabic explanation (for the team)

<div dir="rtl">

معمارية طبقية عميل-خادم: (1) طبقة العميل: تطبيق React 19 + TypeScript بلوحات حسب الدور ورسوم بيانية، يتواصل فقط عبر REST/JSON مع Bearer Token. (2) طبقة الخدمة: كل طلب يمر أولاً بالـ Middleware (التسجيل، فحص API Key، CORS) ثم الـ Routers: المصادقة، التحليلات، الخطر، الاختبارات، التدخلات، الإشعارات، لوحة البيانات، خارطة الطريق. (3) طبقة الذكاء: محرك الخطر داخل نفس عملية Python وقواعد التنبيه بـ SQL؛ وGemini الخدمة الخارجية الوحيدة ويُستدعى من الخادم فقط. (4) طبقة البيانات: PostgreSQL بـ 22 جدولاً و5 Views و2 Materialized Views عبر SQLAlchemy.

</div>

### Expected committee questions

**Q:** Why one FastAPI service rather than microservices?  
**A:** For our team size and a single faculty, one service is simpler to build, test and deploy. Routers are separated by module, so a later split is possible.

**Q:** Does the API-key middleware protect anything?  
**A:** Its exemption list currently matches every path, so it adds no protection. We documented this; the JWT check per route is the real control.

---

## Slide 13 — Database Design

**Time:** 60 seconds  ·  **Speaker:** [Member 3]

**Main message:** A normalized relational schema: users with role profiles, teaching records, and risk and intervention history per student.

### English script

The database has twenty-two tables; the diagram shows the core ones. Users hold login data and the role. Each user can have one profile: student, professor or teaching assistant. Departments group students and courses, and professors teach courses. Enrollments resolve the many-to-many relationship between students and courses with a unique constraint, and attendance and grade records also link a student to a course. On the risk side, a student has many risk assessments over time and many intervention plans, and each plan has ordered actions. Notifications belong to users. Foreign keys use cascade or set-null rules, and enums enforce valid values.

### Arabic explanation (for the team)

<div dir="rtl">

قاعدة البيانات 22 جدولاً والمخطط يعرض الجداول الأساسية. users فيه بيانات الدخول والدور، ولكل مستخدم ملف واحد حسب دوره: students أو professors أو teaching_assistants. الأقسام تجمع الطلاب والمقررات، والأستاذ يدرّس المقررات. enrollments يحل علاقة كثير-إلى-كثير بين الطالب والمقرر مع قيد UNIQUE، وكذلك الحضور وسجلات الدرجات. الطالب له عدة تقييمات خطر عبر الزمن وعدة خطط تدخل، وكل خطة لها خطوات. الإشعارات مرتبطة بالمستخدم. المفاتيح الأجنبية تستخدم CASCADE أو SET NULL، والـ enums تضمن قيماً صحيحة.

</div>

### Expected committee questions

**Q:** Why keep risk assessments as history?  
**A:** Each assessment is stored with its time, so we can show trends and audit how a student's risk changed.

**Q:** Is the schema normalized?  
**A:** Yes, the core tables are in third normal form. GPA on students is a stored derived value maintained by a database trigger.

---

## Slide 14 — UI/UX Design

**Time:** 60 seconds  ·  **Speaker:** [Member 2]

**Main message:** Real screens from the running build, with live-data screens and prototypes labelled honestly.

### English script

These are real screenshots from the running build with the demo database. After login, each role lands on its own dashboard with a role-specific sidebar. The admin dashboard and the students list read live data from PostgreSQL: KPIs, risk distribution, GPA, attendance and risk level per student. The student risk dashboard is a complete interface but still uses sample data, so we label it as a prototype. The design relies on cards, colour-coded risk levels and charts so users can scan quickly.

### Arabic explanation (for the team)

<div dir="rtl">

لقطات شاشة حقيقية من النسخة الحالية مع قاعدة البيانات التجريبية. بعد الدخول يذهب كل مستخدم إلى لوحته مع قائمة جانبية خاصة بدوره. لوحة المدير وقائمة الطلاب تقرأ بيانات حقيقية من PostgreSQL: المؤشرات، توزيع الخطر، والمعدل والحضور ومستوى الخطر لكل طالب. لوحة الطالب واجهة مكتملة لكنها ما زالت ببيانات تجريبية، لذلك عليها علامة Prototype. التصميم يعتمد على البطاقات وألوان مستويات الخطر والرسوم.

</div>

### Expected committee questions

**Q:** Why does the student dashboard greet a different student?  
**A:** It reads a hard-coded sample student from the frontend. Connecting it to the existing student-dashboard endpoint is in our next steps.

---

## Slide 15 — Technology Selection

**Time:** 40 seconds  ·  **Speaker:** [Member 3]

**Main message:** Every technology is verified in the code and mapped to the requirement it serves.

### English script

Every technology here is verified in the code. React with TypeScript gives type-safe components for four role areas; Vite, Tailwind and Recharts speed up the interface and analytics. FastAPI with Pydantic gives a typed REST API with automatic documentation. PostgreSQL and SQLAlchemy keep linked academic records consistent. bcrypt and JWT cover security. The risk engine is plain Python because it must be explainable, and Gemini generates the career roadmap. scikit-learn is listed in the requirements but not used yet, so we do not claim it.

### Arabic explanation (for the team)

<div dir="rtl">

كل التقنيات موجودة فعلاً في الكود. React + TypeScript لمكونات آمنة النوع لأربع مناطق أدوار؛ Vite وTailwind وRecharts للواجهة والتحليلات. FastAPI مع Pydantic لـ API بأنواع محددة وتوثيق تلقائي. PostgreSQL وSQLAlchemy لسلامة العلاقات بين السجلات. bcrypt وJWT للأمان. محرك الخطر بـ Python عادية لأنه يجب أن يكون قابلاً للتفسير، وGemini لخارطة الطريق المهنية. scikit-learn مذكورة في المتطلبات لكنها غير مستخدمة فلا ندّعيها.

</div>

### Expected committee questions

**Q:** Why not Django or Node.js?  
**A:** FastAPI is lightweight, generates OpenAPI documentation automatically, and keeps the backend in Python, the same language as the risk engine and future ML work.

---

## Slide 16 — Project Plan and Task Distribution

**Time:** 40 seconds  ·  **Speaker:** [Member 1]

**Main message:** The baseline plan, actual status against it, and ownership.

### English script

This timeline is our baseline plan from the project schedule: planning and requirements from March, analysis and design through early June, then backend, interface, integration and testing in June and July. Analysis, design and backend were delivered. The interface and integration are partial, and formal testing has not started, so those bars are behind plan. Model training, documentation and deployment move to Project 2. The table shows ownership; it is based on our analysis files and must be confirmed by the team.

### Arabic explanation (for the team)

<div dir="rtl">

الخط الزمني هو الخطة الأساسية من ملف MS Project: التخطيط والمتطلبات من مارس، التحليل والتصميم حتى أوائل يونيو، ثم الخادم والواجهة والتكامل والاختبار في يونيو ويوليو. التحليل والتصميم والخادم تم إنجازها. الواجهة والتكامل جزئيان والاختبار الرسمي لم يبدأ، لذا هي متأخرة عن الخطة. تدريب النموذج والتوثيق والنشر في مشروع 2. جدول المهام مبني على ملفات التحليل ويجب أن يؤكده الفريق.

</div>

### Expected committee questions

**Q:** The plan ended in July. Why is integration still partial?  
**A:** The admin area was integrated first; the professor, TA and student screens were built as prototypes and still need to be connected to existing endpoints. We re-planned this for the next phase.

---

## Slide 17 — Implementation Progress

**Time:** 30 seconds  ·  **Speaker:** [Member 1]

**Main message:** A working core exists; the gaps are integration, model training, testing and security hardening.

### English script

Here is our verified progress. Sign-in works for all four demo roles. The backend exposes eighty-nine API operations, and the database is complete with seed data. Thirteen of fifty-one routed screens read live data; the rest are prototypes. The risk engine works as an API but is rule-based. Automated testing has not started.

### Arabic explanation (for the team)

<div dir="rtl">

التقدم الفعلي الموثق: تسجيل الدخول يعمل للأدوار الأربعة التجريبية. الخادم يوفر 89 عملية API وقاعدة البيانات مكتملة مع بيانات تجريبية. 13 من 51 شاشة تقرأ بيانات حقيقية والباقي نماذج أولية. محرك الخطر يعمل كـ API لكنه قائم على قواعد. لم تبدأ الاختبارات الآلية. كل رقم تم التحقق منه بتشغيل النظام.

</div>

### Expected committee questions

**Q:** How did you verify these numbers?  
**A:** We rebuilt the database from the SQL scripts, ran the backend, logged in with each demo account, counted operations from the OpenAPI document and ran the TypeScript compiler.

---

## Slide 18 — Conclusion and Next Steps

**Time:** 30 seconds  ·  **Speaker:** [Member 1]

**Main message:** The pipeline is designed and its core works; Project 2 will connect, validate and harden it.

### English script

To conclude: risk detection today is late and fragmented. EduPules answers with one pipeline from data to risk, alert and intervention. Its core works: the database, the API, the explainable risk engine and the live admin dashboards. Next, we will connect the remaining screens, automate risk scoring, train and evaluate an ML model, close the security gaps, add tests and deploy. Thank you.

### Arabic explanation (for the team)

<div dir="rtl">

الخلاصة: اكتشاف التعثر اليوم متأخر ومتفرق. EduPules يقدم خطاً واحداً من البيانات إلى الخطر إلى التنبيه إلى التدخل. الأساس يعمل: قاعدة البيانات، الـ API، محرك الخطر القابل للتفسير، ولوحات الإدارة الحية. القادم: ربط باقي الشاشات، أتمتة حساب الخطر، تدريب وتقييم نموذج تعلم آلة، إغلاق ثغرات الأمان، إضافة اختبارات، والنشر. لا ندّعي نتائج نهائية لأن هذا عرض تقدم.

</div>

### Expected committee questions

**Q:** Which dataset will you use for the ML model?  
**A:** Not chosen yet: anonymized NMU records if approved, or a public dataset such as UCI Student Performance. We will report accuracy, precision and recall against the current rule-based baseline.

---

## Slide 19 — References

**Time:** not timed (backup)  ·  **Speaker:** —

**Main message:** Every external claim is traceable to these sources.

### English script

(Not presented. Leave on screen during questions if needed.)

### Arabic explanation (for the team)

<div dir="rtl">

قائمة المراجع بأسلوب IEEE. كل معلومة خارجية في العرض لها مصدر هنا. لا تُعرض شفهياً.

</div>

---

## Backup slide A (deck slide 20) — Backup A: Risk Scoring vs Machine Learning

**Time:** not timed (backup)  ·  **Speaker:** Backup

**Main message:** The current engine is an explainable weighted-scoring model, not a trained ML model.

### English script

(Backup for questions.) The engine computes component risks for GPA, attendance, assignments, quizzes and engagement, combines them with fixed weights, adjusts for grade trend, and maps the result to four levels. The dropout value is derived from the same score, so it is not an independent prediction. A machine-learning model would learn these weights from historical outcomes and must be validated on held-out data.

### Arabic explanation (for the team)

<div dir="rtl">

شريحة احتياطية. المحرك الحالي يحسب خطر كل مكون (المعدل، الحضور، الواجبات، الاختبارات، التفاعل) ويجمعها بأوزان ثابتة، ثم يعدل حسب اتجاه الدرجات، ويحولها إلى أربعة مستويات. قيمة احتمال التسرب مشتقة من نفس الدرجة فليست تنبؤاً مستقلاً. نموذج تعلم الآلة سيتعلم الأوزان من بيانات تاريخية ويُقيَّم على بيانات اختبار منفصلة. هذا هو الفرق بين Risk Scoring وML Prediction.

</div>

### Expected committee questions

**Q:** Is 'dropout_probability' a probability?  
**A:** Not statistically. It is the risk score multiplied by a constant. We will rename it or replace it with a calibrated model output in Project 2.

**Q:** Where do the weights come from?  
**A:** The team set them from common academic indicators; they are not learned from data, which is why we plan to train and compare an ML model.

---

## Backup slide B (deck slide 21) — Backup B: Business Model

**Time:** not timed (backup)  ·  **Speaker:** Backup

**Main message:** The business plan from our Business Model Canvas, required by the NMU-CSE guideline.

### English script

(Backup; move into the main flow if the supervisor wants the business plan presented.) Customers are universities and faculties; staff and students are the users. The value is early risk detection and coordinated support, delivered as a web platform with a subscription or per-student model. These are planning assumptions, not validated market results.

### Arabic explanation (for the team)

<div dir="rtl">

شريحة احتياطية لخطة العمل لأن دليل NMU-CSE يطلب Business Plan. العملاء: الجامعات والكليات، والمستخدمون: الطاقم والطلاب. القيمة: اكتشاف مبكر للخطر ودعم منسق، عبر منصة ويب باشتراك أو سعر لكل طالب. افتراضات تخطيطية وليست نتائج سوق مثبتة.

</div>

### Expected committee questions

**Q:** Do you have pricing?  
**A:** No validated pricing; the canvas lists subscription and per-student pricing as candidate revenue streams.

---

## Backup slide C (deck slide 22) — Backup C: Audit Findings

**Time:** not timed (backup)  ·  **Speaker:** Backup

**Main message:** We found and documented real defects; showing them demonstrates engineering honesty.

### English script

(Backup.) Our audit found: some API routes do not require a token; registration accepts any role; the API-key exemption list matches every path; refreshing a dashboard page crashes because of a React hook-order issue; and one listing endpoint returns a server error. Each has a planned fix.

### Arabic explanation (for the team)

<div dir="rtl">

شريحة احتياطية بنتائج المراجعة: بعض المسارات لا تتطلب token؛ التسجيل يقبل أي دور؛ قائمة استثناء API Key تطابق كل المسارات؛ تحديث صفحة اللوحة يسبب انهيار React (ترتيب الـ hooks)؛ وأحد مسارات القوائم يعيد خطأ 500. لكل مشكلة خطة إصلاح.

</div>

### Expected committee questions

**Q:** Why not fix them before the seminar?  
**A:** Our task was to document the real state. The fixes are small and are the first items in the next sprint.
