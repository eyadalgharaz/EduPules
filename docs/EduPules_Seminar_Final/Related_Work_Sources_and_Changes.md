# EduPules: Related Work Sources and Summary of Changes

**Revision date:** 24 November 2026. I opened and checked all four official pages on this date.

---

## 1. Related Work: what each source supports

### Local systems (national level)

**[1] Mansoura University, "Students" page (MyU portal).** https://www.mans.edu.eg/the-students

- **Purpose:** MyU is the university's student-services portal and a single entry point for students. There is also a mobile app for universities that use the Ibn Al-Haytham student-affairs system.
- **Documented services:**

  | Service (English) | Original name (Arabic) |
  |---|---|
  | Results | نتائج الطلاب |
  | Online fee payment | دفع المصروفات الكترونياً |
  | Course registration and selection | تسجيل واختيار المقررات |
  | Class schedules | الجداول الدراسية |
  | Exam schedules | جداول الامتحانات |
  | E-learning platform | المنصة التعليمية |
  | Student surveys | استبيانات الطلاب |
  | Meal booking | حجز الوجبات |
  | Clinic booking | حجز العيادة الطبية |
  | University email | البريد الإلكتروني |
  | Campus maps | خرائط الجامعة |
  | Library | المكتبة |
  | Research papers and theses | الأبحاث العلمية |
  | Microsoft software | برامج مايكروسوفت |
  | Forms | نماذج واستمارات |

- **Not mentioned on the reviewed page:** academic advising, GPA analytics, performance tracking, risk assessment.

**[2] Assiut University, Student Hub (منصة الطالب).** https://www.mis.aun.edu.eg/studhub

- **Purpose:** a "smart gateway" to each student's academic and financial records and to university services.
- **Documented services:**
  - University ID card request
  - Freshmen medical-exam fee payment
  - University data and fees
  - "My Results" (نتيجتي), only for colleges that publish results through the portal
  - Admission inquiry
  - Smart-card request
  - Official forms download
  - Technical support
  - Housing-status link
- **Not mentioned on the reviewed page:** course registration, schedules, attendance, GPA, academic advising, analytics, prediction.

### Global systems (international level)

**[3] EAB, Navigate360.** https://eab.com/solutions/navigate/

- **Purpose:** a higher-education CRM, cloud-hosted on AWS, that connects administrators, faculty, staff, students and alumni across the student journey.
- **Alerts and student success:** "Automated Alerts & Messaging" and "Faculty Progress Reports". Early alerts are listed as a priority use case.
- **Predictive analytics:** a "Predictive Model" in the reporting suite. EAB states it has deployed more than 200 custom-built predictive models; the slide labels this as a vendor figure.
- **Advising:** "Program Advising", "Cases & Referrals", "Appointments & Surveys", and appointment self-service for students.
- **Planning:** AI course-planning guidance, "Program Explorer" and "Student Journeys". The reviewed page does not document a separate degree-planning feature, so the slide does not claim one.
- **Integration:** system-agnostic. It has pre-built connectors for Blackboard, Brightspace, Canvas, Ellucian, Jenzabar, Moodle, PeopleSoft and Workday, plus APIs.

**[4] Civitas Learning.** https://www.civitaslearning.com/

- **Purpose:** an institutional impact platform. It connects existing systems into one model of the institution, trains AI on that model, and measures the impact of decisions.
- **Predictive analytics:** "Six outcomes, each with its own institution-specific model". The models are retrained each term, and weekly risk scoring surfaces students before they withdraw.
- **Advising:** an advising CRM with case management, shared notes, academic alerts, dynamic lists, and email and SMS outreach.
- **Planning:** degree planning, a schedule builder, registration and appointment scheduling.
- **Integration:** reads from more than 100 systems (SIS, LMS, CRM) and writes actions and results back.

### Accuracy rules followed

- The deck does not say Navigate360 or Civitas lack predictive analytics, planning, advising or student support. The global slide states that both platforms already provide these capabilities.
- For the local portals, the deck says only that their official pages do not describe analytics or advising. It does not claim those features are absent.
- EduPules is not presented as the first system with any single capability. Its proposed contribution is the integration of these capabilities into one workflow, adapted to university-specific regulations.
- EAB Starfish was removed, because the new brief compares two local and two global systems.

---

## 2. Summary of changes

### Related Work: one slide became three

1. **Local systems:** MyU (Mansoura University) and Student Hub (Assiut University). For each system the slide shows its purpose, documented services, the problem it addresses, how it is similar to EduPules, and what EduPules adds. A closing band states the key distinction: student services and records versus academic intelligence and decision support.
2. **Global systems:** Navigate360 and Civitas Learning, compared side by side on five capabilities: alerts, predictive analytics, advising, planning and integration. Two panels follow: "Similarities with EduPules" and "EduPules' proposed difference".
3. **Research gap and proposed contribution:**
   - A comparison of Local, Global and EduPules.
   - The new feature, **AI-Assisted Academic Improvement Planning & Simulation**, shown as a 6-step workflow: analyse performance → find weak areas → personal plan → what-if simulation → advisor approval → execute and monitor.
   - Each step is marked either "Basis exists" (steps 1, 2 and 4: risk drivers and the in-browser GPA simulator exist today) or "Planned" (steps 3, 5 and 6).
   - The theme is "From Academic Monitoring to Academic Improvement".

### Changes to other slides

| Slide | Change |
|---|---|
| Problem | P4 now covers what students should improve. O5 now reads "improvement plan, what-if simulation and advisor approval". |
| Scope | Adds "Planned: improvement plans with advisor approval". |
| Proposed Solution | Stage 5 is now **Improve**: what-if simulation exists; the improvement plan and advisor approval are planned. |
| Progress | The what-if simulator is listed as partial (browser only). The improvement-planning workflow is listed under Remaining. |
| Conclusion | The contribution now reads "from monitoring to improvement". Next step 1 is to build the improvement-planning workflow. |
| References | Now [1]–[4] are the four reviewed systems, followed by the technical sources. |

### Slide count and timing

- The deck now has **19 slides** (previously 17). The extra two slides come from the expanded Related Work section.
- Total speaking time stays at **800 s (≈ 13.3 min)**. To make room, some slides were shortened: Problem, Solution, Requirements, Architecture, ERD, UI and Technology.

### Arabic version (`EduPules_Presentation_AR.pptx`)

- **Layout:** fully right-to-left. The text runs RTL and every layout is mirrored, including cards, the use case diagram, the architecture diagram and the Gantt chart. Arrow icons are flipped.
- **Language:** professional academic Arabic. English is kept for technical terms such as JWT, API, FastAPI, SIS/LMS and CRM.
- **Speaker notes:** written in Arabic.
- **Kept in English:**
  - Team member names, as you instructed.
  - ERD entity names, because they are schema identifiers. A caption on the slide explains this.
  - IEEE references, which are standard in their original language. A note on the slide explains this.
- **Font:** Segoe UI, which is installed on Windows and supports Arabic.

### Other deliverables

- PDF exports of both versions.
- `Speaker_Script_EN.md` and `Speaker_Script_AR.md`.

### Unchanged

The Advisor naming (the Teaching Assistant functionality presented as Advisor), the six-member team, and all diagrams, screenshots and verified implementation facts.
