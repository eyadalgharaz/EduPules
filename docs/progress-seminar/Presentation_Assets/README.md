# EduPules — Presentation assets

## brand/
- `bg_dark.png` — navy gradient background with a subtle dot grid (cover, problem, solution and conclusion slides)
- `bg_light.png` — white background with a soft royal-blue glow (content slides)
- `pulse_teal.png`, `pulse_blue.png` — the "pulse" motif that echoes the EduPules name
- Icons are Lucide line icons (via `react-icons`), embedded in the deck as PNG. No third-party logos are used.

## screenshots/
Real captures from the current build (frontend production build + FastAPI + PostgreSQL loaded with `database/001–006`), taken on 22 Nov 2026 by logging in with the demo accounts.

| File | Screen | Data source | Used on slide |
|---|---|---|---|
| admin_dashboard.png | Admin (Dean) dashboard `/admin/cmd` | Live API | 14 (hero) |
| admin_students.png, crop_admin_students.png | Students list `/admin/cmd/students` | Live API | 14 (crop) |
| crop_student_dashboard.png | Student dashboard `/student` (top part) | Sample data (prototype) | 14 |
| admin_analytics.png | Admin analytics | Live API (recommendation cards hard-coded) | — |
| login.png | Sign-in page | — | — |
| professor_dashboard.png, professor_risk_heatmap.png, professor_quizzes.png | Professor area | Sample data | — |
| ta_dashboard.png | TA dashboard | Sample data | — |

**Notes**
- The crops cut the original 16:9 captures to 2.2:1 without scaling distortion.
- Captures whose on-screen sample text referred to the legacy role (alert recommendations, intervention pages, the lower part of the student dashboard, simulation and career pages) were removed from this folder.
- The in-app logo still shows an earlier spelling of the name; screenshots were not edited.
