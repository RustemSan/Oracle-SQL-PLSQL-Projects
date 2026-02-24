-- Main script for Task 1: PL/SQL Procedures
-- This script automates schema creation and data population

-- Open log file to record session output
spool run-me.log
set serveroutput on
set echo on

-- STEP 1: Execute database schema creation
-- Using local paths without ./ to help DataGrip analysis
@create.sql

-- STEP 2: Compile all population procedures
@fill_team.sql
@fill_tournaments.sql
@fill_participation.sql

-- STEP 3: Verify and demonstrate data population

-- Check C_TEAM table
SELECT count(*) AS initial_teams FROM c_team;
BEGIN
    -- Populate with 30 records and truncate existing data
    fill_c_team(30, True);
END;
/
SELECT count(*) AS final_teams FROM c_team;

-- Check C_TOURNAMENTS table
SELECT count(*) AS initial_tournaments FROM c_tournaments;
BEGIN
    -- Populate with 10 records and truncate
    fill_c_tournaments(10, True);
END;
/
SELECT count(*) AS final_tournaments FROM c_tournaments;

-- Check C_PARTICIPATION table
SELECT count(*) AS initial_relations FROM c_participation;
BEGIN
    -- Generate 50 random relations between teams and tournaments
    fill_c_participation(50);
END;
/
SELECT count(*) AS final_relations FROM c_participation;

-- Close log file and finalize
spool off