CREATE TABLE student (
  student_id NUMBER PRIMARY KEY,
  name VARCHAR2(50),
  attendance NUMBER,
  quiz NUMBER,
  mid NUMBER,
  final_exam NUMBER
);

-- Inserting 5 dummy records
INSERT INTO student (student_id, name, attendance, quiz, mid, final_exam)
VALUES (1, 'John Doe', 9, 12, 20, 45);

INSERT INTO student (student_id, name, attendance, quiz, mid, final_exam)
VALUES (2, 'Jane Smith', 8, 10, 18, 40);

INSERT INTO student (student_id, name, attendance, quiz, mid, final_exam)
VALUES (3, 'David Jones', 7, 11, 19, 42);

INSERT INTO student (student_id, name, attendance, quiz, mid, final_exam)
VALUES (4, 'Emily Brown', 10, 14, 23, 48);

INSERT INTO student (student_id, name, attendance, quiz, mid, final_exam)
VALUES (5, 'Michael Taylor', 9, 13, 22, 46);





CREATE OR REPLACE PROCEDURE calculate_grade IS
  CURSOR student_cursor IS
    SELECT student_id, name, attendance, quiz, mid, final_exam
    FROM student;
  total_marks NUMBER;
  grade CHAR(1);
BEGIN
  FOR student_rec IN student_cursor LOOP
    -- Calculate total marks
    total_marks := (student_rec.attendance * 0.10) +
                   (student_rec.quiz * 0.15) +
                   (student_rec.mid * 0.25) +
                   (student_rec.final_exam * 0.50);
    
    -- Determine grade based on total marks
    IF total_marks >= 80 THEN
      grade := 'A';
    ELSIF total_marks >= 70 THEN
      grade := 'B';
    ELSIF total_marks >= 60 THEN
      grade := 'C';
    ELSIF total_marks >= 40 THEN
      grade := 'D';
    ELSE
      grade := 'F';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('Student: ' || student_rec.name || ' Total Marks: ' || total_marks || ' Grade: ' || grade);
  END LOOP;
END;
/

-- Executing the procedure
BEGIN
  calculate_grade;
END;
/

