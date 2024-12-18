-- 1. Структура базы данных

-- Таблица студентов
CREATE TABLE Student (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    birth_date DATE NOT NULL,
    contact_info JSONB NOT NULL,
    UNIQUE (full_name, birth_date)
);

-- Таблица преподавателей
CREATE TABLE Teacher (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    birth_date DATE NOT NULL,
    contact_info JSONB NOT NULL,
    UNIQUE (full_name, birth_date)
);

-- Таблица предметов
CREATE TABLE Subject (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

-- Таблица курсов
CREATE TABLE Course (
    id SERIAL PRIMARY KEY,
    subject_id INT NOT NULL,
    teacher_id INT NOT NULL,
    year INT NOT NULL,
    semester VARCHAR(10) NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES Subject (id) ON DELETE CASCADE,
    FOREIGN KEY (teacher_id) REFERENCES Teacher (id) ON DELETE CASCADE
);

-- Таблица оценок
CREATE TABLE Grade (
    id SERIAL PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    grade INT CHECK (grade BETWEEN 1 AND 5),
    grade_date DATE NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Student (id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Course (id) ON DELETE CASCADE
);

-- 2. Тестовые данные

-- Данные для студентов
INSERT INTO Student (full_name, birth_date, contact_info) VALUES
('Иван Иванов', '2000-01-01', '{"email": "ivan@example.com", "phone": "1234567890"}'),
('Петр Петров', '1999-05-15', '{"email": "petr@example.com", "phone": "9876543210"}'),
('Мария Смирнова', '2001-07-20', '{"email": "maria@example.com", "phone": "4561237890"}');

-- Данные для преподавателей
INSERT INTO Teacher (full_name, birth_date, contact_info) VALUES
('Сергей Сергеев', '1980-03-10', '{"email": "sergey@example.com", "phone": "1231231234"}'),
('Ольга Васильева', '1975-12-25', '{"email": "olga@example.com", "phone": "5675675678"}');

-- Данные для предметов
INSERT INTO Subject (name, description) VALUES
('Математика', 'Описание курса по математике'),
('История', 'Описание курса по истории'),
('Физика', 'Описание курса по физике');

-- Данные для курсов
INSERT INTO Course (subject_id, teacher_id, year, semester) VALUES
(1, 1, 2024, 'Весенний'),
(2, 2, 2024, 'Осенний'),
(3, 1, 2024, 'Летний');

-- Данные для оценок
INSERT INTO Grade (student_id, course_id, grade, grade_date) VALUES
(1, 1, 5, '2024-01-10'),
(1, 2, 4, '2024-06-15'),
(2, 1, 3, '2024-01-12'),
(2, 3, 5, '2024-07-20'),
(3, 2, 2, '2024-06-20');
