CREATE TABLE IF NOT EXISTS users (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    full_name TEXT NOT NULL,
    role VARCHAR(20) CHECK (role in ('teacher', 'student')) NOT NULL
);

CREATE TABLE IF NOT EXISTS groups (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS subjects (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS classrooms (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS events (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    subject_id INT REFERENCES subjects(id),
    group_id INT REFERENCES groups(id),
    teacher_id INT REFERENCES users(id),
    classroom_id INT REFERENCES classrooms(id),
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    qr_secret UUID DEFAULT gen_random_uuid()
);

CREATE TABLE IF NOT EXISTS attendance_records (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    event_id INT REFERENCES events(id) ON DELETE CASCADE,
    student_id INT REFERENCES users(id) ON DELETE CASCADE,
    marked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    marked_by VARCHAR(20) CHECK (marked_by IN ('student_scan', 'teacher_manual')) DEFAULT 'student_scan',
    UNIQUE(event_id, student_id)
);