-- ==================================================================
-- MAIN SCRIPT (run-me.sql)
-- Purpose: Automates schema creation, data insertion, and IO testing.
-- ==================================================================

SET ECHO ON
SET FEEDBACK ON
SET VERIFY ON
SET SERVEROUTPUT ON
SET LINESIZE 200
SET PAGESIZE 100

-- Recording to log file
SPOOL run-me.log



-- 1. initialize DataBase system
PROMPT >>> CREATING TABLES AND TRIGGERS
@create.sql



-- 2. Populate Initial Data
PROMPT >>> INSERTING INITIAL DATA (Approx. 1000 rows from semestral project)
-- Turning off because we just inserting 1000 rows to table and the log file will be huge
SET FEEDBACK OFF
SET ECHO OFF

@insert.sql

-- Turning on output after insertion
SET FEEDBACK ON
SET ECHO ON
SET VERIFY ON


-- Unit Tests
PROMPT >>> TEST IO 1: Pilot Flight OVERLAP TRIGGER
-- Scenario: Assign pilot #1 to a flight that overlaps with their existing schedule.
-- Expected Result: ORA-20001 (IO Error)

BEGIN
    DBMS_OUTPUT.PUT_LINE('Attempting to insert overlapping flight for Pilot ID: 1');
    -- Note: Times for flight ID 1 are fixed in insert.sql. We try to add a conflicting one.
    INSERT INTO pilot_flight (id_employee, id_flight, position)
    VALUES (1, 2, 'Conflict Test');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Caught Expected Error: ' || SQLERRM);

end;
/

PROMPT >>> TEST IO 2: AIRCRAFT CAPACITY TRIGGER
BEGIN
    DBMS_OUTPUT.PUT_LINE('Testing capacity for Flight ID: 17 (Limit: 60)');
    FOR i IN 1..100 LOOP
        INSERT INTO ticket (id_passenger, id_flight, seat_number, class, price)
        VALUES (1, 17, 'SN-' || i, 'Economy', 100);
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Caught Expected Error: ' || SQLERRM);
END;
/


-- ------------------------------------------------------------------
-- 4. Final Cleanup (Optional) and Finish
-- ------------------------------------------------------------------

PROMPT >>> DATABASE INITIALIZATION COMPLETE.
SPOOL OFF
EXIT;