# References — EduPules Progress Seminar

IEEE style. All web sources were opened and checked on **22 November 2026**. Each entry lists what it supports in the deck.

## Related systems and research

**[1]** Civitas Learning, "Institutional Impact Platform." [Online]. Available: https://www.civitaslearning.com/platform/ (accessed Nov. 22, 2026).
- Supports (slide 6): unifies institutional data, institution-specific predictive models ("Actionable Analytics"), academic alerts, a staff CRM with case management, and connections to 100+ systems (SIS, LMS, CRM).

**[2]** EAB, "Navigate360." [Online]. Available: https://eab.com/solutions/navigate360/ (accessed Nov. 22, 2026).
- Supports (slide 6): cloud student-success CRM; early alerts and automation, predictive analytics, case management, appointments, and a student app. The "850+ institutions" figure and the enterprise pricing based on enrollment and scope are **vendor statements**, labelled as such on the slide.

**[3]** EAB, "Starfish." [Online]. Available: https://eab.com/solutions/starfish/ (accessed Nov. 22, 2026).
- Supports (slide 6): early alert, scheduling, case management, operational and strategic analytics, and degree planning. The product page does not describe integrations, and the slide says so.

**[4]** K. Alalawi, R. Athauda, and R. Chiong, "An extended learning analytics framework integrating machine learning and pedagogical approaches for student performance prediction and intervention," *International Journal of Artificial Intelligence in Education*, vol. 35, pp. 1239–1287, 2025, doi: 10.1007/s40593-024-00429-7. Available: https://link.springer.com/article/10.1007/s40593-024-00429-7
- Supports (slide 6, notes): the SPPA framework; course-specific predictive models built from continuous-assessment data; quasi-experimental evaluation in six courses; significant gains in some courses but not in others; limitations (prediction only after the first assessment, manual data uploads, separate logins, small number of courses).

**[5]** K. Alalawi, R. Athauda, R. Chiong, and I. Renner, "Evaluating the student performance prediction and action framework through a learning analytics intervention study," *Education and Information Technologies*, vol. 30, pp. 2887–2916, 2025, doi: 10.1007/s10639-024-12923-5.
- Background reference: the earlier evaluation of the same SPPA framework, cited by [4].

## Technical documentation (technologies verified in the repository)

**[6]** FastAPI documentation. [Online]. Available: https://fastapi.tiangolo.com/ — backend framework (`fastapi==0.115.0` in `backend/requirements.txt`).

**[7]** React documentation. [Online]. Available: https://react.dev/ — frontend library (`react ^19.0.0` in `frontend/package.json`).

**[8]** PostgreSQL documentation. [Online]. Available: https://www.postgresql.org/docs/ — database (`database/001_schema.sql`; `docs/SETUP.md` asks for PostgreSQL 15+).

**[9]** SQLAlchemy 2.0 documentation. [Online]. Available: https://docs.sqlalchemy.org/en/20/ — ORM (`sqlalchemy==2.0.36`).

**[10]** M. Jones, J. Bradley, and N. Sakimura, "JSON Web Token (JWT)," RFC 7519, IETF, May 2015. Available: https://www.rfc-editor.org/rfc/rfc7519 — token format used through `python-jose` (HS256).

**[11]** Google, "Gemini API documentation." [Online]. Available: https://ai.google.dev/gemini-api/docs — the `gemini-2.5-flash:generateContent` endpoint called by `backend/app/api/career_roadmap.py`.

Other confirmed tools (no external claims are made about them): TypeScript 5.6, Vite 6, Tailwind CSS 4, Recharts 2, React Router 7, Framer Motion, Pydantic 2, Uvicorn, passlib/bcrypt, Git.

## Internal project documents

**[12]** EduPules team, *System Analysis package* (`System_Anlaysis.rar`), 2026. It contains: requirement-gathering interviews (`وصفي/Requirement gathering.docx`), use-case scenarios, the MS Project schedule (`اياد/gannt chart.pdf`, WBS, RBS, resources), the Business Model Canvas (`شروق/Business model.jpeg`), the SDLC approach, ER, DFD, class, use case, 4+1 view and state-machine diagrams.
- Supports: motivation (slide 2), the baseline plan (slide 16), the business model (backup B) and the task-distribution hints.
- Note: `Data flow diagram.jpeg` in the archive could not be extracted (the RAR entry is truncated or corrupt).

**[13]** NMU-CSE, *The Main Plan for Graduation Project-1 & Graduation Project-2, 2026–2027* (`Main_Requirements_for_the_Graduation_Project_2027_2026_Students.pdf`). This defines the required presentation contents and the appearance rules (minimum 24 pt font, bullets, visuals).

## Datasets

No external dataset is used. All figures in the deck come from the project's **demo seed data** (`database/002_seed.sql`, `005_demo_login_accounts.sql`, `006_demo_professor_workload.sql`). For Project 2, a candidate public dataset is the UCI Student Performance dataset (https://archive.ics.uci.edu/dataset/320/student+performance). It is **not yet used**, and the team must confirm it before citing it as a source.
