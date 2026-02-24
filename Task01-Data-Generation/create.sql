-- team
-- tournaments
-- participation
DROP Table c_Participation CASCADE CONSTRAINTS;
DROP TABLE c_Team CASCADE CONSTRAINTS;
DROP TABLE c_Tournaments CASCADE CONSTRAINTS;

-- teams
CREATE TABLE c_Team (
    id             integer not null,
    name           varchar2(64) not null,
    coach          varchar2(64) not null,
    sponsor        varchar2(64) not null
);


ALTER TABLE c_Team ADD CONSTRAINT c_Team_pk PRIMARY KEY ( id );


-- tournaments
CREATE TABLE  c_Tournaments (
    id              integer not null,
    name            varchar2(64) not null
);

ALTER TABLE c_Tournaments ADD CONSTRAINT c_Tournaments_pk PRIMARY KEY ( id );



-- relation table
CREATE TABLE c_Participation (
    team_id              integer not null,
    tournament_id        integer not null,
    year                 integer not null
) ;


ALTER TABLE c_Participation
    ADD CONSTRAINT c_Participation_pk PRIMARY KEY (team_id, tournament_id);


ALTER TABLE c_Participation
    ADD CONSTRAINT fk_participation_team FOREIGN KEY (team_id)
        REFERENCES c_Team (id);


ALTER TABLE c_Participation
    ADD CONSTRAINT fk_participation_tournament FOREIGN KEY (tournament_id)
        REFERENCES c_Tournaments (id);