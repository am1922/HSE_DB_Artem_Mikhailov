# Отчет по проекту базы данных

## 1. Структура базы данных

### Таблицы
1. **Student**: 
   - Хранит данные о студентах.
   - Поля:
     - `id` (INT, PK): Уникальный идентификатор студента.
     - `full_name` (VARCHAR): Полное имя.
     - `birth_date` (DATE): Дата рождения.
     - `contact_info` (JSONB): Контактная информация (телефон, email).

2. **Teacher**:
   - Хранит данные о преподавателях.
   - Поля:
     - `id` (INT, PK): Уникальный идентификатор преподавателя.
     - `full_name` (VARCHAR): Полное имя.
     - `birth_date` (DATE): Дата рождения.
     - `contact_info` (JSONB): Контактная информация.

3. **Subject**:
   - Список предметов.
   - Поля:
     - `id` (INT, PK): Уникальный идентификатор предмета.
     - `name` (VARCHAR): Название предмета.
     - `description` (TEXT): Описание курса.

4. **Course**:
   - Связь предметов и преподавателей.
   - Поля:
     - `id` (INT, PK): Уникальный идентификатор курса.
     - `subject_id` (INT, FK): Идентификатор предмета.
     - `teacher_id` (INT, FK): Идентификатор преподавателя.
     - `year` (INT): Год.
     - `semester` (VARCHAR): Семестр.

5. **Grade**:
   - Оценки студентов.
   - Поля:
     - `id` (INT, PK): Уникальный идентификатор оценки.
     - `student_id` (INT, FK): Идентификатор студента.
     - `course_id` (INT, FK): Идентификатор курса.
     - `grade` (INT): Оценка (1-5).
     - `grade_date` (DATE): Дата выставления оценки.

---

## 2. Описание запросов

### 2.1. Анализ данных
1. **Список студентов по предмету**
   - Показывает всех студентов, изучающих указанный предмет.
   ```sql
   SELECT S.full_name, S.contact_info 
   FROM Student S
   JOIN Grade G ON S.id = G.student_id
   JOIN Course C ON G.course_id = C.id
   JOIN Subject Sub ON C.subject_id = Sub.id
   WHERE Sub.name = 'Математика';

2. **Средний балл студента по всем предметам**
    - Вычисляет среднюю оценку студента.
    ```sql
    SELECT S.full_name, AVG(G.grade) AS avg_grade 
    FROM Student S
    JOIN Grade G ON S.id = G.student_id
    GROUP BY S.id;

3. **Рейтинг преподавателей**
    - Сортирует преподавателей по средней оценке их студентов.
    ```sql
    SELECT T.full_name, AVG(G.grade) AS avg_grade 
    FROM Teacher T
    JOIN Course C ON T.id = C.teacher_id
    JOIN Grade G ON C.id = G.course_id
    GROUP BY T.id
    ORDER BY avg_grade DESC;

### 2.1. Анализ данных

1. **Добавление нового студента**
    ```sql
    INSERT INTO Student (full_name, birth_date, contact_info)
    VALUES ('Иван Иванов', '2000-01-01', '{"email": "ivan@example.com", "phone": 
    "1234567890"}');

2. **Обновление контактной информации преподавателя**
    ```sql
    UPDATE Teacher
    SET contact_info = jsonb_set(contact_info, '{phone}', '"9876543210"')
    WHERE id = 1;

3. **Удаление предмета с учетом зависимостей**
    ```sql
    DELETE FROM Subject WHERE id = 1;

4. **Вставка новой оценки**
```sql
    INSERT INTO Grade (student_id, course_id, grade, grade_date)
    VALUES (1, 1, 5, '2024-12-17');
