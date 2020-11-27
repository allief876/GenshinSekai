pray :-
	/* pray untuk isi sanity pakai mukjizat, sanity full */

	mukjizat(Object),
	player_inventory(Inventory),
	search_inventory(Inventory, Object, D),
	D == 1,
	
	player_sanity(Sanity),
	player_max_sanity(P_max_sanity),
	Sanity >= P_max_sanity,
	write('You are sane, why do you need a miracle?'), nl, !.

pray :-
	/* pray untuk isi sanity pakai mukjizat, sanity hampir full */

	mukjizat(Object),
	player_inventory(Inventory),
	search_inventory(Inventory, Object, D),
	D == 1,
	
	player_sanity(Sanity),
	player_max_sanity(P_max_sanity),
	Sanity + 10 > Max_thirst, !,
	
	New_sanity is P_max_sanity - Sanity,
    retract(player_sanity(Sanity)),
    asserta(player_sanity(New_sanity)),

	delete_inventory(OldInventory, Object, NewInventory),
	paste_inventory(NewInventory),

	format("Your sanity has been increased by ~p.", [New_sanity]),
	write('You used 1 mukjizat.'), nl, !.

pray :-
	/* pray untuk isi sanity pakai mukjizat, sanity tidak hampir full */

	mukjizat(Object),
	player_inventory(Inventory),
	search_inventory(Inventory, Object, D),
	D == 1,
	
	player_sanity(Sanity),
	player_max_sanity(P_max_sanity),
	Sanity + 10 =< Max_thirst, !,

    New_sanity is Sanity + 10,
    retract(player_sanity(Sanity)),
    asserta(player_sanity(New_sanity)),

	delete_inventory(Inventory, Object, NewInventory),
	paste_inventory(NewInventory),

	write('Your sanity has been increased by 10.'), nl,
    write('You used 1 mukjizat.'), nl, !.

pray:-
	/* pray untuk isi ulang sanity pakai mukjizat, tidak punya mukjizat */

	mukjizat(Object),
	player_inventory(Inventory),
	search_inventory(Inventory, Object, D),
    D \== 1, !,
	
	write("Too bad, you don't have a miracle..."), nl, !.
