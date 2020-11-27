sleep :-
    game_running(true),

    player_pos(X,Y),
    itb(kos,X,Y),
    
    write('What do you wish for:'),nl,nl,
    write('1. Equipment (100 gold)'),nl,
    write('2. Sanity    (Min. 3 gold)'),nl,
    
    read(Input),
    executeSleep(Input).
    
sleep :-
    game_running(true),

    write('Can\'t sleep here.'),fail.
    
sleep :-
    game_running(false),
    
    write('Please start the game first.'),nl,!.
    
executeSleep(1) :-
    player_gold(Gold),
    Gold >= 100,
    
    random(0,70,J1),
    J2 is round(J1**0.5),
    J is 8-J2,
    J > 0,!,
    format('You slept for ~p hours.\n',[J]),
    
    New_gold is Gold-100,
    retract(player_gold(Gold)),
    asserta(player_gold(New_gold)),
    
    randomEquipment(New_Equipment),
    equipmentObj(New_Equipment,E_faculty,_,_),
    
    player_inventory(Inventory),
    modify_player_inventory(New_Equipment),
    
    format('You wake up with a new ~p (~p)!\n',[New_Equipment, E_faculty]),!.
    
executeSleep(1) :-
    player_pos(X,Y),
    itb(kos,X,Y),
    
    player_gold(Gold),
    Gold < 3,
    
    write('Not enough gold.'),nl,!.
 
executeSleep(1) :-
    player_pos(X,Y),
    itb(kos,X,Y),
    
    write('Arghh.. Can\'t sleep...'),nl,!.
    
executeSleep(2) :-
    player_gold(Gold),
    Gold >= 3,
    
    random(0,70,J1),
    J2 is round(J1**0.5),
    J is 8-J2,
    J > 0,!,
    format('You slept for ~p hours.\n',[J]),
    
    New_gold is Gold-3,
    retract(player_gold(Gold)),
    asserta(player_gold(New_gold)),
    
    random(Gacha),
    Gacha_limit is J2/10,
    Gacha > Gacha_limit,!,
    
    random(J1,70,San),
    San1 is round(San/2),
    Add1 is 40-San1,
    player_sanity(P_sanity),
    player_max_sanity(P_max_sanity),
    Diff is P_max_sanity-P_sanity,
    least(Add1, Diff, Add),
    New_gold >= Add,
    New_new_gold is New_gold-Add,
    retract(player_gold(New_gold)),
    asserta(player_gold(New_new_gold)),
    format('Your sanity has increased by ~p.\n',[Add]),
    format('You pay ~p gold.\n',[Add]),
    New_sanity is P_sanity+Add,
    retract(player_sanity(P_sanity)),
    asserta(player_sanity(New_sanity)),!.

executeSleep(2) :-
    player_pos(X,Y),
    itb(kos,X,Y),
    
    player_gold(Gold),
    Gold < 3,
    
    write('Not enough gold.'),nl,!.
 
executeSleep(2) :-
    player_pos(X,Y),
    itb(kos,X,Y),
    
    write('Arghh.. Can\'t sleep...'),nl,!.
    
least(X,Y,X) :-
    X < Y,!.

least(X,Y,Y) :-
    Y =< X.