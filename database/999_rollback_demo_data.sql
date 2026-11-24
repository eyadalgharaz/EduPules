-- ============================================================
-- EduGuard AI — مسح كل بيانات الديمو (Rollback كامل)
-- ============================================================
-- بيمسح بالضبط كل اللي تمت إضافته في:
--   005_demo_login_accounts.sql
--   006_demo_professor_workload.sql
--
-- وبيرجع الداتابيز لحالتها الأصلية تمامًا (الـ 120 student
-- والـ 24 course الأصليين متلمسوش خالص).
--
-- الترتيب مهم جدًا: لازم نمسح الجداول الفرعية (attendances,
-- enrollments) قبل ما نمسح الكورسات، وبعدين نمسح teaching_assistants/
-- professors/students قبل ما نمسح users، عشان foreign key constraints.
-- ============================================================

-- 1. مسح الـ attendance بتاع الكورسات الديمو
DELETE FROM attendances
WHERE course_id IN (SELECT id FROM courses WHERE code IN ('CS310', 'CS320'));

-- 2. مسح الـ enrollments بتاع الكورسات الديمو
DELETE FROM enrollments
WHERE course_id IN (SELECT id FROM courses WHERE code IN ('CS310', 'CS320'));

-- 3. مسح الكورسات الديمو نفسها
DELETE FROM courses
WHERE code IN ('CS310', 'CS320');

-- 4. مسح صف الـ student المرتبط بحساب alice الديمو
DELETE FROM students
WHERE user_id = (SELECT id FROM users WHERE email = 'alice@student.eduguard.edu');

-- 5. مسح صف الـ teaching_assistant المرتبط بحساب ta.marcus الديمو
DELETE FROM teaching_assistants
WHERE user_id = (SELECT id FROM users WHERE email = 'ta.marcus@eduguard.edu');

-- 6. مسح صف الـ professor المرتبط بحساب j.anderson الديمو
DELETE FROM professors
WHERE user_id = (SELECT id FROM users WHERE email = 'j.anderson@eduguard.edu');

-- 7. مسح الـ 4 حسابات users الديمو نفسها
DELETE FROM users
WHERE email IN (
    'admin@eduguard.edu',
    'j.anderson@eduguard.edu',
    'ta.marcus@eduguard.edu',
    'alice@student.eduguard.edu'
);

-- ============================================================
-- تأكيد إن كل حاجة اتمسحت (شغّل ده يدويًا للتأكد):
-- SELECT count(*) FROM users WHERE email LIKE '%eduguard.edu%';
-- المفروض يرجع 0
--
-- SELECT count(*) FROM courses WHERE code IN ('CS310','CS320');
-- المفروض يرجع 0
--
-- SELECT count(*) FROM students;
-- المفروض يرجع 120 (مش 121)
-- ============================================================
