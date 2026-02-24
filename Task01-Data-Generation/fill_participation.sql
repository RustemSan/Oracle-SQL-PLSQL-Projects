-- vytvoreni procedury, ktera plni vztahovou tabulku
-- plni ji na zaklade pseudonahodneho vyberu klici z tabulek, na ktere je vazana
-- pres cizi klic

CREATE or REPLACE PROCEDURE fill_c_participation(rowsNum INTEGER) AUTHID CURRENT_USER IS
    TYPE T_RECS IS TABLE OF C_PARTICIPATION%ROWTYPE;
    recs T_RECS;

    numToIns INTEGER := rowsNum;
    insStep  INTEGER := 10; -- size of 1 batch

    errors_in_array EXCEPTION;
    PRAGMA EXCEPTION_INIT(errors_in_array, -24381);
BEGIN

    EXECUTE IMMEDIATE 'DELETE FROM C_PARTICIPATION';
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Table c_Participation cleared!');


    -- start of outer loop
    WHILE (numToIns > 0) LOOP
            IF ( insStep > numToIns) THEN insStep := numToIns;
            END IF;

            recs := T_RECS();

            -- start of inner loop
            FOR i IN 1..insStep LOOP
                    recs.extend;

                    SELECT id INTO recs(i).TEAM_ID
                    FROM C_TEAM ORDER BY DBMS_RANDOM.VALUE
                        FETCH FIRST 1 ROWS ONLY;

                    SELECT id INTO recs(i).TOURNAMENT_ID
                    FROM C_TOURNAMENTS ORDER BY DBMS_RANDOM.VALUE
                        FETCH FIRST 1 ROWS ONLY;

                    recs(i).year := FLOOR(DBMS_RANDOM.VALUE(2000, 2026));

                end loop;
            -- end of inner loop

            BEGIN
            FORALL j IN 1..recs.COUNT SAVE EXCEPTIONS
                INSERT INTO C_PARTICIPATION VALUES recs(j);
            EXCEPTION
            WHEN errors_in_array THEN
                FOR i IN 1..SQL%BULK_EXCEPTIONS.COUNT LOOP
                    DBMS_OUTPUT.PUT_LINE('Row error: ' ||
                        SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE));
                END LOOP;
            END;


        DBMS_OUTPUT.PUT_LINE('Succesfully inserted ' ||  sql%ROWCOUNT || ' rows');
        COMMIT;
        numToIns := numToIns - insStep;
    end loop;
    -- end of outer loop
    DBMS_OUTPUT.PUT_LINE('-- Insertion Finished!');
end fill_c_participation;
/