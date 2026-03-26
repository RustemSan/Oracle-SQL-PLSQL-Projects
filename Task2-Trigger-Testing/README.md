# Oracle PL/SQL - implementace složitějších IO

## Cíle

* Integritní omezení (IO) jsou tvrzení o datech, která musí databáze splňovat. Jaká data jsou v DB povolena a jaká ne.
* Pokud to lze, snažíme se je implementovat pomocí standardních prostředků databáze (SQL v našem případě). Takovým IO říkáme **deklarativní**. Jsou to **domény atributů**, **NOT NULL**, **PRIMARY | UNIQUE | FOREIGN KEY** a **CHECK**.
* Pokud to nelze, musíme využít dalších prostředků na straně DB serveru - konkrétně **TRIGGERS | PACKAGES | PROCEDURES | FUNCTIONS** v případě PL/SQL nebo implementovat taková IO až na úrovni aplikace (což může přinášet komplikace).
* Cílem tohoto úkolu je nad mým vlastním schématem formulovat dvě složitější integritní omezení. Jedno implementovat pomocí **TRIGGERU** a jedno pomocí **PACKAGE** v jazyku PL/SQL.

## Zadání

* Ve svém schématu zformulujte **dvě složitější IO (taková, která nejde implementovat deklativně v SQL)**.
* Jedno z nich implementujte pomocí **TRIGGER**u v PL/SQL.
* Druhé implementujte pomocí **PACKAGE** v PL/SQL. Zde si musíte uvědomit:
    * že uživateli/aplikaci (v praxi) zakážete přímé DML operace nad dotčenou tabulkou/tabulkami,
    * to v našem školním prostředí nedokážete proto si to jen myslete,
    * a místo toho mu poskytnete **PACKAGE**, který bude mít funkce/procedury, kterými tyto **DML operace nahradíte**.
* Pro implementaci každého IO vypracujte **testovací scénář** (prakticky unit test), kterým ověříte, že vaše řešení
    * **funguje v pozitivním** (data na vstupu či při změnách jsou povolena)
    * i **negativním případě** (data na vstupu či při změnách nejsou povolena).

Vysledkem bude opět jeden hlavní script **run-me.sql**, který vyrobí **run-me.log** jako v předchozím úkolu.

Součástí odevzdání bude také:

* SQL script pro vytvoření databáze
     * tento script **bude formou komentářů obshahovat formulací integritních omezení, která budete implementovat**
* případně insert script pro naplnění databáze vhodnými daty, bude-li to třeba.
* scripty, které implementují vámi definovaná IO
* hlavní script **run-me.sql**
* **run-me.log** jako výsledný protokol


