pray :-
	/* pray untuk isi sanity pakai mukjizat, sanity full */
    
    game_running(true),
    in_test_room(true),
    prayed(false),
    
	player_inventory(Inventory),
	search_inventory(Inventory, 'Mukjizat', D),
	D == 1,
	
	player_sanity(Sanity),
	player_max_sanity(P_max_sanity),
	Sanity >= P_max_sanity,
	write('You are sane, why do you need a miracle?'), nl, !.

pray :-
	/* pray untuk isi sanity pakai mukjizat, sanity hampir full */
    
    game_running(true),
    in_test_room(true),
    prayed(false),
    
	player_inventory(Inventory),
	search_inventory(Inventory, 'Mukjizat', D),
	D == 1,
	
	player_sanity(Sanity),
	player_max_sanity(P_max_sanity),
	player_semester(Sem),
	Add_sanity is round(5*(1.5**Sem)),
	Temp_sanity is Sanity + Add_sanity,
	Temp_sanity > P_max_sanity, !,
	
	New_sanity is P_max_sanity-Sanity,
    retract(player_sanity(Sanity)),
    asserta(player_sanity(P_max_sanity)),!,

	delete_inventory(Inventory, 'Mukjizat', NewInventory),
	paste_inventory(NewInventory),
	
	retract(prayed(false)),
	asserta(prayed(true)),

	format("Your sanity has been increased by ~p.", [New_sanity]),
	write('You used 1 mukjizat.'), nl, !.

pray :-
	/* pray untuk isi sanity pakai mukjizat, sanity tidak hampir full */
    
    game_running(true),
    in_test_room(true),
    prayed(false),
    
	player_inventory(Inventory),
	search_inventory(Inventory, 'Mukjizat', D),
	D == 1,!,
	
	player_sanity(Sanity),
	player_max_sanity(P_max_sanity),
	player_semester(Sem),
	Add_sanity is round(5*(1.5**Sem)),
	Temp_sanity is Sanity + Add_sanity,
	Temp_sanity =< P_max_sanity, !,
    
    retract(player_sanity(Sanity)),
    asserta(player_sanity(Temp_sanity)),!,

	delete_inventory(Inventory, 'Mukjizat', NewInventory),
	paste_inventory(NewInventory),
	
	retract(prayed(false)),
	asserta(prayed(true)),

	format('Your sanity has been increased by ~p.\n',[Add_sanity]),
    write('You used 1 mukjizat.'), nl, !.

pray :-
	/* pray untuk isi ulang sanity pakai mukjizat, tidak punya mukjizat */
    
    game_running(true),
    in_test_room(true),
    prayed(false),
    
	player_inventory(Inventory),
	search_inventory(Inventory, 'Mukjizat', D),
    D \== 1, !,
	
	write('Too bad, you don\'t have a miracle...'), nl, !.
	
pray :-
	/* pray untuk isi ulang sanity pakai mukjizat, baru pakai mukjizat */
    
    game_running(true),
    in_test_room(true),
    prayed(true),
    
    write('You just prayed! Now is the time to answer!'),nl,!.
    

pray :-
    /* pray di luar battle screen */
    
    in_test_room(false),
    write('No monsters nearby.'),nl,!.
