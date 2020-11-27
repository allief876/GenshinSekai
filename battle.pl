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
    
    game_running(true),
    in_test_room(true),
    
    monster_status(_, _, _, M_defense, M_progress),
    status(_, P_intelligence, _, P_sanity),
    
    player_faculty(P_faculty),
    equipment(Equipment),
    equipmentObj(Equipment, P_faculty, P_int_mul, _),
    P_int_use is P_intelligence*P_int_mul,
    
    calc_damage(P_int_use, M_defense, M_damage),
    New_M_progress is M_progress-M_damage,
    
    New_M_progress > 0,
    update_status(New_M_progress, P_sanity,monster),!,
    
    last_cheat(T),
    New_T is T+1,
    retract(last_cheat(T)),
    asserta(last_cheat(New_T)),
    retract(prayed(_)),
    asserta(prayed(false)),
    
    format('You answered ~p points!\n', [M_damage]),!,
    monster_attack.
    
answer :- 
    /* answer, monster mati */
    
    game_running(true),
    in_test_room(true),
    
    monster_status(_, _, _, M_defense, M_progress),
    status(_, P_intelligence, _, P_sanity),
    
    player_faculty(P_faculty),
    equipment(Equipment),
    equipmentObj(Equipment, P_faculty, P_int_mul, _),
    P_int_use is P_intelligence*P_int_mul,
    
    calc_damage(P_int_use, M_defense, M_damage),
    New_M_progress is M_progress-M_damage,
    
    New_M_progress < 1,!,
    
    last_cheat(T),
    New_T is T+1,
    retract(last_cheat(T)),
    asserta(last_cheat(New_T)),
    retract(prayed(_)),
    asserta(prayed(false)),
    
    format('You answered ~p points!\n', [M_damage]),!,
    update_status(New_M_progress,P_sanity,monster).
    
answer :-
    /* answer, tidak ada monster */
    
    game_running(true),
    in_test_room(false),
    write('No tests nearby.'),nl,!.
    
    
cheat :- 
    /* cheat, monster belum mati */
    
    game_running(true),
    in_test_room(true),
    last_cheat(T),
    T > 2,
    
    monster_status(_, _, _, M_defense, M_progress),
    status(_, P_intelligence, _, P_sanity),
    
    player_faculty(P_faculty),
    equipment(Equipment),
    equipmentObj(Equipment, P_faculty, P_int_mul, _),
    P_int_use is P_intelligence*P_int_mul,
    
    Use_P_intelligence is P_int_use*1.4,
    calc_damage(Use_P_intelligence, M_defense, M_damage),
    New_M_progress is M_progress-M_damage,
    
    New_M_progress > 0,
    update_status(New_M_progress, P_sanity,monster),!,
    
    retract(last_cheat(T)),
    asserta(last_cheat(0)),
    retract(prayed(_)),
    asserta(prayed(false)),!,
    
    format('You cheated and answered ~p points!\n', [M_damage]),
    monster_attack.
    
cheat :- 
    /* cheat, monster mati */
    
    game_running(true),
    in_test_room(true),
    last_cheat(T),
    T > 2,
    
    monster_status(_, _, _, M_defense, M_progress),
    status(_, P_intelligence, _, P_sanity),
    
    player_faculty(P_faculty),
    equipment(Equipment),
    equipmentObj(Equipment, P_faculty, P_int_mul, _),
    P_int_use is P_intelligence*P_int_mul,
    
    Use_P_intelligence is P_int_use*1.4,
    calc_damage(Use_P_intelligence, M_defense, M_damage),
    New_M_progress is M_progress-M_damage,
    
    New_M_progress < 1,!,
    
    retract(last_cheat(T)),
    asserta(last_cheat(0)),
    retract(prayed(_)),
    asserta(prayed(false)),!,
    
    format('You cheated and answered ~p points!\n', [M_damage]),
    update_status(New_M_progress,P_sanity,monster).
    
cheat :- 
    /* belum bisa cheat */
    
    game_running(true),
    in_test_room(true),
    last_cheat(T),
    T < 3,!,
    write('No cheats available!'),nl.
    
cheat :-
    /* cheat, tidak ada monster */
    
    game_running(true),
    in_test_room(false),
    write('No tests nearby.'),nl,!.

monster_attack :-
    /* monster melakukan normal attack */
    
    game_running(true),
    in_test_room(true),
        
    monster_status(M_type, _, M_attack, _, M_progress),
    status(_, _, P_luck, P_sanity),
    
    turn(3),
    
    player_faculty(P_faculty),
    equipment(Equipment),
    equipmentObj(Equipment, P_faculty, _, P_luck_mul),
    P_luck_use is P_luck*P_luck_mul,
    
    calc_damage(M_attack, P_luck_use, P_damage),
    New_P_sanity is P_sanity-P_damage,
    
    retract(turn(1)),
    asserta(turn(2)),!,
    
    format('~p dealt ~p damage to your sanity!\n', [M_type, P_damage]),
    update_status(M_progress,New_P_sanity,player).

monster_attack :-
    /* monster melakukan normal attack */
    
    game_running(true),
    in_test_room(true),
    
    monster_status(M_type, _, M_attack, _, M_progress),
    status(_, _, P_luck, P_sanity),
    
    turn(T),
    T1 is T mod 4,
    T1 \== 3,
    
    player_faculty(P_faculty),
    equipment(Equipment),
    equipmentObj(Equipment, P_faculty, _, P_luck_mul),
    P_luck_use is P_luck*P_luck_mul,
    
    calc_damage(M_attack, P_luck_use, P_damage),
    New_P_sanity is P_sanity-P_damage,
    
    New_T is T+1,
    retract(turn(T)),
    asserta(turn(New_T)),!,
    
    format('~p dealt ~p damage to your sanity!\n', [M_type, P_damage]),
    update_status(M_progress,New_P_sanity,player).
    
monster_attack :-
    /* monster melakukan special attack */
    
    game_running(true),
    in_test_room(true),
    
    monster_status(M_type, _, M_attack, _, M_progress),
    status(_, _, P_luck, P_sanity),
    
    turn(T),
    T1 is T mod 4,
    T1 == 3,
    
    player_faculty(P_faculty),
    equipment(Equipment),
    equipmentObj(Equipment, P_faculty, _, P_luck_mul),
    P_luck_use is P_luck*P_luck_mul,
    
    Use_P_luck is P_luck_use/2,
    calc_damage(M_attack, Use_P_luck, P_damage),
    New_P_sanity is P_sanity-P_damage,
    
    New_T is T+1,
    retract(turn(T)),
    asserta(turn(New_T)),
    
    format('~p dealt ~p damage to your sanity!\n', [M_type, P_damage]),
    update_status(M_progress,New_P_sanity,player).
    
sekip :-
    /* berhasil skip */
    
    game_running(true),
    in_test_room(true),
    
    random(X),
    X >= 0.5,!,
    
    monster_status(M_type, _, _, _, _),
    retract(monster_status(M_type, _, _, _, _)),
    
    retract(in_test_room(true)),
    asserta(in_test_room(false)),
    
    retract(turn(_)),
    asserta(turn(0)),
    retract(last_cheated(_)),
    asserta(last_cheated(0)),
    retract(prayed(_)),
    
    format('You successfully skipped your ~p!',[M_type]),nl,!.
    
sekip :-
    /* gagal sekip */
    
    game_running(true),
    in_test_room(true),!,
    
    write('Your dosen noticed you trying to skip!'),nl,
    monster_attack.
    
sekip :-
    /* sekip tapi ga lagi nugas */
    
    game_running(true),
    
    write('No tests nearby.'),nl,!.
    
update_status(New_M_progress,New_P_sanity,monster) :-
    /* selesai TA */
    
    game_running(true),
    in_test_room(true),
    
    New_P_sanity > 0,
    New_M_progress =< 0,
    monster_status(ta, M_semester, M_attack, _, _),
    retract(monster_status(ta, M_semester, M_attack, _, _)),
    
    tugas_akhir_status(TA_semester, TA_attack, TA_defense, TA_progress),
    retract(tugas_akhir_status(TA_semester, TA_attack, TA_defense, TA_progress)),
    asserta(tugas_akhir_status(TA_semester, TA_attack, TA_defense, 0)),
    
    player_sanity(P_sanity),
    player_max_sanity(P_max_sanity),
    player_intelligence(P_intelligence),
    player_luck(P_luck),
    player_faculty(P_faculty),
    equipment(Equipment),
    equipmentObj(Equipment, P_faculty, P_int_mul, P_luck_mul),
    P_int_use is P_intelligence*P_int_mul,
    P_luck_use is P_luck*P_luck_mul,
    
    GPA1 is P_sanity/P_max_sanity,
    Bias1 is P_int_use/P_luck_use,
    Bias is Bias1-1,
    GPA2 is GPA1+Bias,
    least(GPA2, 1, GPA3),
    GPA is GPA3*4,!,
    
    retract(turn(_)),
    asserta(turn(0)),
    
    retract(last_cheat(_)),
    asserta(last_cheat(0)),!,
    
    retract(prayed(_)),
    
    graduate(GPA),!.
    
    
update_status(New_M_progress,New_P_sanity,monster) :-
    /* menang */
    
    game_running(true),
    in_test_room(true),
    
    New_P_sanity > 0,
    New_M_progress =< 0,!,
    monster_status(M_type, M_semester, M_attack, _, _),
    M_type \== ta,
    retract(monster_status(M_type, M_semester, M_attack, _, _)),
    player_luck(P_luck),
    
    retract(in_test_room(true)),
    asserta(in_test_room(false)),
    
    player_gold(Gold),
    
    player_faculty(P_faculty),
    equipment(Equipment),
    equipmentObj(Equipment, P_faculty, _, P_luck_mul),
    P_luck_use is P_luck*P_luck_mul,
    
    calc_damage(M_attack, P_luck_use, Add_gold1),
    getType(M_type,X),
    Add_gold2 is Add_gold1-M_semester,
    Add_gold is Add_gold2+X*3,
    New_gold is Gold+Add_gold,
    retract(player_gold(Gold)),
    asserta(player_gold(New_gold)),
    
    format('\nYou finished your ~p.\n',[M_type]),
    
    retract(turn(_)),
    asserta(turn(0)),
    
    retract(last_cheat(_)),
    asserta(last_cheat(0)),!,
    
    retract(prayed(_)),

    player_sks(SKS),
    New_sks is SKS + 1,
    retract(player_sks(SKS)),
    asserta(player_sks(New_sks)),!,
    
    format('\n~p gold added to wallet.\n',[Add_gold]),
    format('You get an extra SKS, current total: ~p SKS.\n',[New_sks]),

    add_progress(M_type),
    finish_assignments,
    naik_semester, !.

update_status(_,New_P_sanity,player) :-
    /* kalah */
    
    game_running(true),
    in_test_room(true),
    
    New_P_sanity =< 0,
    
    game_over,!.

update_status(New_M_progress,New_P_sanity,_) :-
    /* belum menang */
    
    game_running(true),
    in_test_room(true),
    
    New_M_progress > 0,
    New_P_sanity > 0,
    monster_status(M_type, M_semester, M_attack, M_defense, _),
    retract(monster_status(M_type, M_semester, M_attack, M_defense, _)),
    asserta(monster_status(M_type, M_semester, M_attack, M_defense, New_M_progress)),
    
    player_sanity(P_sanity),
    retract(player_sanity(P_sanity)),
    asserta(player_sanity(New_P_sanity)),!.

tugas_akhir_max_sanity(3500).

fAss :-
    /* mulai pengerjaan tugas akhir (final assignment) */
    
    game_running(true),
    player_pos(X,Y),
    itb(lab,X,Y),!,
    
    tugas_akhir_status(TA_semester, TA_attack, TA_defense, TA_progress),
    asserta(monster_status(ta, TA_semester, TA_attack, TA_defense, TA_progress)),
    
    retract(in_test_room(false)),
    asserta(in_test_room(true)),
    
    write('Get ready to do your Final Assignment!'),nl,nl,
    format('Semester            : ~p\n',[TA_semester]),
    format('Stress rating       : ~p\n',[TA_attack]),
    format('Difficulty          : ~p\n',[TA_defense]),
    format('Points remaining    : ~p\n',[TA_progress]).
    
fAss :-
    /* tidak di lab */
    
    game_running(true),
    player_pos(X,Y),
    \+ itb(lab,X,Y),
    
    write('Your Final Assignment can only be done in the Lab (L)!'),nl,!.
    
graduate(GPA) :-
    /* cum laude */
    
    GPA > 3.5,!,
    write('Congratulations! You completed your Final Assignment!'),nl,nl,
    format('Graduating with a ~2f GPA, ', [GPA]),
    write('you obtain the honor of Cum Laude!'),nl,
    write('Good luck in the real world!'),nl,!.
    
graduate(GPA) :-
    /* sangat memuaskan */
    
    GPA > 2.5,!,
    write('Congratulations! You completed your Final Assignment!'),nl,nl,
    format('Graduating with a ~2f GPA, ', [GPA]),
    write('you obtain the honor of Highly Satisfactory!'),nl,
    write('Good luck in the real world!'),nl,!.
    
graduate(GPA) :-
    /* memuaskan */
    
    write('Congratulations! You completed your Final Assignment!'),nl,nl,
    format('Graduating with a ~2f GPA, ', [GPA]),
    write('you obtain the honor of Satisfactory!'),nl,
    write('Good luck in the real world!'),nl,!.
    
    