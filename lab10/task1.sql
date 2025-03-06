-- 2. Write a basic PL/SQL block to retrieve and display the name and salary of the em-
-- ployee with ID 101.
DECLARE
    v_name employees.name%TYPE;
    v_salary employees.salary%TYPE;
BEGIN
    
    SELECT name, salary 
    INTO v_name, v_salary
    FROM employees
    WHERE employee_id = 101;

  
    DBMS_OUTPUT.PUT_LINE('Employee Name: ' || v_name);
    DBMS_OUTPUT.PUT_LINE('Salary: ' || TO_CHAR(v_salary, '999,999.99'));
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No employee found with ID 101.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/

-- 3. Create a function called get_employee_count that returns the total number of em-
-- ployees in a given department (pass department_id as parameter).
CREATE OR REPLACE FUNCTION get_employee_count(p_department_id NUMBER)
RETURN NUMBER 
IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM employees
    WHERE department_id = p_department_id;

    RETURN v_count;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RETURN -1;  
END get_employee_count;
/


-- 4. Create a trigger named update_hire_date_trg that automatically updates the
-- last_hire_date in the departments table when a new employee is hired with a
-- more recent hire date. Run check_trigger.sql to verify if it’s working correctly.
CREATE OR REPLACE TRIGGER update_hire_date_trg
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    UPDATE departments d
    SET d.last_hire_date = :NEW.hire_date
    WHERE d.department_id = :NEW.department_id
    AND (d.last_hire_date IS NULL OR d.last_hire_date < :NEW.hire_date);
END;
/


-- 5. Write a PL/SQL block using a cursor to display the names of all employees in department_id=2

DECLARE
    CURSOR emp_cursor IS
        SELECT name FROM employees WHERE department_id = 2;
    v_name employees.name%TYPE;
BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO v_name;
        EXIT WHEN emp_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Employee: ' || v_name);
    END LOOP;
    CLOSE emp_cursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
