calc_damage(Attack, Defense, 0) :-
    /* basis damage */
    
    Ratio is Attack/Defense,
    Damage is Attack*Ratio,
    Damage < 1,!.

calc_damage(Attack, Defense, Damage) :-
    Ratio is Attack/Defense,
    Damage is round(Attack*Ratio).

answer :- 
    /* answer, monster belum mati */
    
    in_test_room(true),
    
    monster_status(_, _, _, M_defense, M_progress),
    player_status(_, P_intelligence, _, P_sanity),
    calc_damage(P_intelligence, M_defense, M_damage),
    New_M_progress is M_progress-M_damage,
    
    New_M_progress > 0,
    update_status(New_M_progress, P_sanity,monster),!,
    
    last_cheat(T),
    New_T is T+1,
    retract(last_cheat(T)),
    asserta(last_cheat(New_T)),
    
    format('You answered ~p points!\n', [M_damage]),!,
    monster_attack.
    
answer :- 
    /* answer, monster mati */
    
    in_test_room(true),
    
    monster_status(_, _, _, M_defense, M_progress),
    player_status(_, P_intelligence, _, P_sanity),
    calc_damage(P_intelligence, M_defense, M_damage),
    New_M_progress is M_progress-M_damage,
    
    New_M_progress < 1,!,
    
    last_cheat(T),
    New_T is T+1,
    retract(last_cheat(T)),
    asserta(last_cheat(New_T)),
    
    format('You answered ~p points!\n', [M_damage]),!,
    update_status(New_M_progress,P_sanity,monster).
    
cheat :- 
    /* cheat, monster belum mati */
    
    in_test_room(true),
    last_cheat(T),
    T > 2,
    
    monster_status(_, _, _, M_defense, M_progress),
    player_status(_, P_intelligence, _, P_sanity),
    Use_P_intelligence is P_intelligence*1.4,
    calc_damage(Use_P_intelligence, M_defense, M_damage),
    New_M_progress is M_progress-M_damage,
    
    New_M_progress > 0,
    update_status(New_M_progress, P_sanity,monster),!,
    
    retract(last_cheat(T)),
    asserta(last_cheat(0)),!,
    
    format('You cheated and answered ~p points!\n', [M_damage]),
    monster_attack.
    
cheat :- 
    /* cheat, monster mati */
    
    in_test_room(true),
    last_cheat(T),
    T > 2,
    
    monster_status(_, _, _, M_defense, M_progress),
    player_status(_, P_intelligence, _, P_sanity),
    Use_P_intelligence is P_intelligence*1.4,
    calc_damage(Use_P_intelligence, M_defense, M_damage),
    New_M_progress is M_progress-M_damage,
    
    New_M_progress < 1,!,
    
    retract(last_cheat(T)),
    asserta(last_cheat(0)),!,
    
    format('You cheated and answered ~p points!\n', [M_damage]),
    update_status(New_M_progress,P_sanity,monster).
    
cheat :- 
    /* cheat, monster mati */
    
    in_test_room(true),
    last_cheat(T),
    T < 3,!,
    write('No cheats available!'),nl.
    
monster_attack :-
    /* monster melakukan normal attack */
    
    monster_status(M_type, _, M_attack, _, M_progress),
    player_status(_, _, P_luck, P_sanity),
    
    turn(T),
    T mod 4 > 0,
    
    calc_damage(M_attack, P_luck, P_damage),
    New_P_sanity is P_sanity-P_damage,
    
    New_T is T+1,
    retract(turn(T)),
    asserta(turn(New_T)),!,
    
    format('~p dealt ~p damage to your sanity!\n', [M_type, P_damage]),
    update_status(M_progress,New_P_sanity,player).
    
monster_attack :-
    /* monster melakukan special attack */
    
    monster_status(M_type, _, M_attack, _, M_progress),
    player_status(_, _, P_luck, P_sanity),
    
    turn(T),
    
    Use_P_luck is P_luck/2,
    calc_damage(M_attack, Use_P_luck, P_damage),
    New_P_sanity is P_sanity-P_damage,
    
    New_T is T+1,
    retract(turn(T)),
    asserta(turn(New_T)),
    
    format('~p dealt ~p damage to your sanity!\n', [M_type, P_damage]),
    update_status(M_progress,New_P_sanity,player).
    
update_status(New_M_progress,_,monster) :-
    /* menang */
    
    New_M_progress < 0,
    monster_status(M_type, M_semester, M_attack, M_defense, M_progress),
    retract(monster_status(M_type, M_semester, M_attack, M_defense, M_progress)),
    
    retract(in_test_room(true)),
    asserta(in_test_room(false)),
    
    player_gold(Gold),
    Add_gold is M_semester*10,
    New_gold is Gold+Add_gold,
    retract(player_gold(Gold)),
    asserta(player_gold(New_gold)),
    
    update_tugas(M_type),
    
    turn(T),
    retract(turn(T)),
    asserta(turn(0)),
    
    last_cheat(C),
    retract(last_cheat(C)),
    asserta(last_cheat(0)),!,
    
    write('10 gold added to wallet.'),nl.

update_status(_,New_P_sanity,player) :-
    /* kalah */
    
    New_P_sanity < 0,
    player_sanity(P_sanity),
    retract(player_sanity(P_sanity)),
    asserta(player_sanity(0)),!,
    
    write('You lost!'),nl.

update_status(New_M_progress,New_P_sanity,_) :-
    /* belum menang */
    
    New_M_progress > 0,
    New_P_sanity > 0,
    monster_status(M_type, M_semester, M_attack, M_defense, M_progress),
    retract(monster_status(M_type, M_semester, M_attack, M_defense, M_progress)),
    asserta(monster_status(M_type, M_semester, M_attack, M_defense, New_M_progress)),
    
    player_sanity(P_sanity),
    retract(player_sanity(P_sanity)),
    asserta(player_sanity(New_P_sanity)),!.
    
    
update_tugas(M_type) :-
    format('You finished your ~p \n',[M_type]).
    