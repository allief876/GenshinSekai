init_player :-
    game_running(false),
    
    write('Choose your faculty: '),nl,
    write('1. STEI'),nl,
    write('2. FMIPA'),nl,
    write('3. FTTM'),nl,
    write('> '),
    read(X),
    X > 0,
    X < 4,!,
    retract(player_pos(_,_)),
    retract(player_faculty(_)),
    retract(player_semester(_)),
    retract(equipment(_)),
    retract(player_intelligence(_)),
    retract(player_luck(_)),
    retract(player_sanity(_)),
    retract(player_max_sanity(_)),
    retract(player_max_sks(_)),
    retract(player_gold(_)),
    asserta(player_pos(0,0)),
    asserta(player_sks(0)),
    asserta(player_max_sks(18)),
    set_faculty(X),
    player_faculty(Fakultas),
    format('Congratulations, your application has been accepted! Welcome to ~p ITB!',[Fakultas]).
    
set_faculty(1) :-
    /* pemain memilih STEI */
    
    asserta(player_faculty('STEI')),
    asserta(player_semester(1)),
    asserta(equipment(arsip_TPB)),
    asserta(player_intelligence(14)),
    asserta(player_luck(15)),
    asserta(player_sanity(70)),
    asserta(player_max_sanity(70)),
    asserta(player_gold(0)).
    
set_faculty(2) :-
    /* pemain memilih FMIPA */
    
    asserta(player_faculty('FMIPA')),
    asserta(player_semester(1)),
    asserta(equipment(penggaris)),
    asserta(player_intelligence(16)),
    asserta(player_luck(12)),
    asserta(player_sanity(60)),
    asserta(player_max_sanity(60)),
    asserta(player_gold(0)).

set_faculty(3) :-
    /* pemain memilih FTTM */
    
    asserta(player_faculty('FTTM')),
    asserta(player_semester(1)),
    asserta(equipment(jaket_angkatan)),
    asserta(player_intelligence(12)),
    asserta(player_luck(18)),
    asserta(player_sanity(80)),
    asserta(player_max_sanity(80)),
    asserta(player_gold(30)).

/* status tokoh */

status(P_semester, P_intelligence, P_luck, P_sanity) :-
    player_semester(P_semester),
    player_intelligence(P_intelligence),
    player_luck(P_luck),
    player_sanity(P_sanity).

status :-
    semester,!,
    sanity,!,
    intelligence,!,
    luck,!,
    sks,!,
    wallet,!.

semester :- 
    player_semester(P_semester),
    format('Semester: ~p\n', [P_semester]).

sks :-
    player_sks(P_sks),
    player_max_sks(P_max_sks),
    format('SKS: ~p/~p\n',[P_sks, P_max_sks]).
    
sanity :-
    player_sanity(P_sanity),
    player_max_sanity(P_max_sanity),
    format('Sanity: ~p/~p\n', [P_sanity, P_max_sanity]).
    
intelligence :-
    player_intelligence(P_intelligence),
    format('Intelligence: ~p\n', [P_intelligence]).
    
luck :-
    player_luck(P_luck),
    format('Luck: ~p\n', [P_luck]).

wallet :-
    player_gold(P_gold),
    format('Gold: ~p\n', [P_gold]).
    
monster_status :-
    monster_status(M_type,M_semester,M_attack,M_defense,M_progress),
    format('Type: ~p\n',[M_type]),
    format('Semester: ~p\n',[M_semester]),
    format('Stress Rating: ~p\n',[M_attack]),
    format('Difficulty: ~p\n',[M_defense]),
    format('Points Remaining: ~p\n',[M_progress]).