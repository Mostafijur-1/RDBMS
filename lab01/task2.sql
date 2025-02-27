CREATE OR REPLACE PROCEDURE prime_generator(s IN NUMBER) AS
  sum_of_primes NUMBER := 0;
  current_number NUMBER := 2;
  
  -- Function to check if a number is prime
  FUNCTION is_prime(n NUMBER) RETURN BOOLEAN IS
    i NUMBER;
  BEGIN
    IF n < 2 THEN
      RETURN FALSE;
    END IF;
    
    FOR i IN 2..TRUNC(SQRT(n)) LOOP
      IF n MOD i = 0 THEN
        RETURN FALSE;
      END IF;
    END LOOP;
    
    RETURN TRUE;
  END;
  
BEGIN
  -- Generate primes and calculate their sum
  WHILE sum_of_primes + current_number <= s LOOP
    IF is_prime(current_number) THEN
      DBMS_OUTPUT.PUT_LINE(current_number);
      sum_of_primes := sum_of_primes + current_number;
    END IF;
    current_number := current_number + 1;
  END LOOP;
END;
/

-- Executing the function
BEGIN
  prime_generator(20);
END;
/
