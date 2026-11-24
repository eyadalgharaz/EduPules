-- ============================================================
-- EduGuard AI — Demo Professor Workload (standalone, safe to re-run)
-- ============================================================
-- WHY THIS EXISTS:
-- 005_demo_login_accounts.sql created the demo professor account
-- (j.anderson@eduguard.edu) and linked it to a `professors` row, but
-- never assigned any courses to it. That's correct in isolation —
-- the account logs in fine — but the dashboard then (accurately)
-- flags "no courses assigned" and shows Pass Rate 0% / Fail Rate —
-- for that professor, since there's genuinely nothing to compute
-- from.
--
-- This script gives j.anderson two real courses in the Computer
-- Science department, enrolls a handful of existing CS students in
-- them with realistic grades, and adds a few weeks of attendance —
-- so the demo professor account looks like an active, populated
-- professor instead of an empty shell.
--
-- IMPORTANT: this does NOT touch any existing courses, professors,
-- enrollments, or attendance — it only adds new rows scoped to the
-- 2 new courses created here.
--
-- SAFE TO RE-RUN: guarded with WHERE NOT EXISTS / ON CONFLICT, so
-- running this twice will not create duplicate courses or rows.
-- ============================================================

-- 1. Two new courses taught by the demo professor
INSERT INTO courses (code, name, professor_id, department_id, credits, semester, year, is_active, max_students, description)
SELECT 'CS310', 'Web Application Development',
       p.id, 1, 3, 'Fall', 2024, TRUE, 35,
       'Full-stack web development: REST APIs, frontend frameworks, authentication, and deployment.'
FROM professors p
JOIN users u ON u.id = p.user_id
WHERE u.email = 'j.anderson@eduguard.edu'
  AND NOT EXISTS (SELECT 1 FROM courses WHERE code = 'CS310');

INSERT INTO courses (code, name, professor_id, department_id, credits, semester, year, is_active, max_students, description)
SELECT 'CS320', 'Mobile App Development',
       p.id, 1, 3, 'Fall', 2024, TRUE, 30,
       'Native and cross-platform mobile development, UI patterns, and app lifecycle management.'
FROM professors p
JOIN users u ON u.id = p.user_id
WHERE u.email = 'j.anderson@eduguard.edu'
  AND NOT EXISTS (SELECT 1 FROM courses WHERE code = 'CS320');

-- 2. Enroll 8 existing CS students (ids 1-8) into both new courses,
--    with realistic grades spread across pass/fail so dashboard
--    stats have something real to calculate
INSERT INTO enrollments (student_id, course_id, status, grade)
SELECT s.id, c.id, 'active', g.grade
FROM (VALUES (1,88.0),(2,76.5),(3,92.0),(4,65.0),(5,58.5),(6,81.0),(7,45.0),(8,73.5)) AS g(student_id, grade)
JOIN students s ON s.id = g.student_id
JOIN courses c ON c.code = 'CS310'
WHERE NOT EXISTS (
    SELECT 1 FROM enrollments e WHERE e.student_id = s.id AND e.course_id = c.id
);

INSERT INTO enrollments (student_id, course_id, status, grade)
SELECT s.id, c.id, 'active', g.grade
FROM (VALUES (1,79.0),(2,84.5),(3,69.0),(4,90.5),(5,55.0),(6,62.0),(7,71.5),(8,48.0)) AS g(student_id, grade)
JOIN students s ON s.id = g.student_id
JOIN courses c ON c.code = 'CS320'
WHERE NOT EXISTS (
    SELECT 1 FROM enrollments e WHERE e.student_id = s.id AND e.course_id = c.id
);

-- 3. Four weeks of attendance per student per course (every 7 days),
--    mostly present with a realistic mix of late/absent
INSERT INTO attendances (student_id, course_id, date, status, recorded_by)
SELECT s.id, c.id, d.session_date::date,
       (CASE WHEN (s.id + d.week) % 6 = 0 THEN 'absent'
             WHEN (s.id + d.week) % 5 = 0 THEN 'late'
             ELSE 'present' END)::attendance_status,
       u.id
FROM (VALUES (1),(2),(3),(4),(5),(6),(7),(8)) AS sid(student_id)
JOIN students s ON s.id = sid.student_id
JOIN courses c ON c.code IN ('CS310', 'CS320')
JOIN users u ON u.email = 'j.anderson@eduguard.edu'
CROSS JOIN (
    SELECT generate_series(1, 4) AS week,
           (CURRENT_DATE - ((4 - generate_series(1, 4)) * 7))::text AS session_date
) AS d
WHERE NOT EXISTS (
    SELECT 1 FROM attendances a
    WHERE a.student_id = s.id AND a.course_id = c.id AND a.date = d.session_date::date
);

-- ============================================================
-- Verify (run manually):
-- SELECT code, name FROM courses WHERE professor_id =
--   (SELECT id FROM professors WHERE user_id =
--     (SELECT id FROM users WHERE email = 'j.anderson@eduguard.edu'));
-- Expect: CS310, CS320
--
-- SELECT count(*) FROM enrollments WHERE course_id IN
--   (SELECT id FROM courses WHERE code IN ('CS310','CS320'));
-- Expect: 16
-- ============================================================
