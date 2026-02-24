CREATE OR REPLACE PROCEDURE fill_c_team(rowsNum INTEGER, doTruncate BOOLEAN) AUTHID CURRENT_USER IS
    startId INTEGER;
    prepRow C_TEAM%ROWTYPE;

    TYPE T_NAME IS VARRAY(20) OF VARCHAR2(64);
    names T_NAME := T_NAME('FC Sparta', 'Manchester City', 'Manchester United', 'Real Madrid', 'FC Barcelona',
                                'Bayern Munich', 'Chelsea FC', 'AC Milan', 'Juventus', 'PSG');
    coaches T_NAME := T_NAME('Hans', 'Pep', 'Karlo', 'Zinedine', 'Jurgen',
                             'Mikel', 'Diego', 'Thomas', 'Alex', 'Arsen');

    wsponsors T_NAME := T_NAME('Nike', 'Adidas', 'Puma', 'Spotify', 'Emirates',
                              'Samsung', 'Toyota', 'Coca-Cola', 'Pepsi', 'Microsoft');

--  v_name VARCHAR2(64);
--  v_coach VARCHAR2(64);
--  v_sponsor VARCHAR2(64);

BEGIN
    IF (doTruncate) THEN
        Execute Immediate 'Delete FROM c_Team';
        COMMIT;

        DBMS_OUTPUT.PUT_LINE('Table c_Team cleared');

        startId := 1;
    ELSE
        SELECT NVL(MAX(id), 0) + 1 INTO startId FROM C_TEAM;

        DBMS_OUTPUT.PUT_LINE('Adding records starting from ID #' || startId);

    end if;

    DBMS_OUTPUT.PUT_LINE('c_Team Table cleared');

    FOR i IN 1..rowsNum LOOP
            prepRow.ID := startId;

            prepRow.NAME    :=  names(FLOOR(DBMS_RANDOM.value(1, names.COUNT + 1)));
            prepRow.COACH   :=  coaches(FLOOR(DBMS_RANDOM.value(1, coaches.COUNT + 1)));
            prepRow.SPONSOR :=  wsponsors(FLOOR(DBMS_RANDOM.value(1, wsponsors.COUNT + 1)));

            INSERT INTO c_Team VALUES prepRow;
            startId := startId + 1;
    end loop;

    DBMS_OUTPUT.PUT_LINE('Successfully inserted ' || rowsNum || ' rows into c_Team');

    COMMIT;



end fill_c_team;
/