CREATE OR REPLACE PROCEDURE fill_c_tournaments(rowsNum INTEGER, doTruncate BOOLEAN) AUTHID CURRENT_USER IS
    startId INTEGER;
    prepRow C_TOURNAMENTS%ROWTYPE;

    TYPE T_NAME IS VARRAY(20) OF VARCHAR2(64);
    names T_NAME := T_NAME('Champions League', 'Europa League', 'Premier League', 'La Liga', 'Serie A',
                           'Bundesliga', 'Ligue 1', 'FA Cup', 'World Cup', 'Euro 2024');


BEGIN
    IF (doTruncate) THEN
        EXECUTE IMMEDIATE 'Delete FROM C_TOURNAMENTS';
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Table c_Tournaments cleared!');
        startId := 1;
    ElSE
        SELECT nvl(MAX(id), 0) + 1 INTO startId from C_TOURNAMENTS;
        DBMS_OUTPUT.PUT_LINE('Adding tournaments starting from ID #' || startId);
    end if;



    FOR i in 1..rowsNum LOOP
        prepRow.ID := startId;


        prepRow.NAME := names(FLOOR(DBMS_RANDOM.VALUE(1, names.COUNT + 1)));

        INSERT INTO C_TOURNAMENTS VALUES prepRow;
        startId := startId + 1;

    end loop;


    DBMS_OUTPUT.PUT_LINE('Successfully inserted ' || rowsNum || ' rows into c_Tournaments');

    COMMIT;


end fill_c_tournaments;
/