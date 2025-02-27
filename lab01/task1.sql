DECLARE
  current_year NUMBER := EXTRACT(YEAR FROM SYSDATE);
  decade_start NUMBER;
  decade_label VARCHAR2(10);
BEGIN
  IF MOD(current_year, 10) = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Yes');
  ELSE
    DBMS_OUTPUT.PUT_LINE('No');
  END IF;
  
  -- Calculate the start year of the current decade
  decade_start := current_year - MOD(current_year, 10);
  decade_label := TO_CHAR(decade_start) || 's';
  
  DBMS_OUTPUT.PUT_LINE('The ' || decade_label);
END;
/
