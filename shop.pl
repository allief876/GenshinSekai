/* File: shop.pl */
/* NIM - Nama: 13519221 - Allief Nuriman */
/* Mengunjungi & berinteraksi di shop */

/* shop */

add_inventory([], Object, [Object]) :- !.

add_inventory([Head|Tail], Object, [Head|Tail2]) :-
    add_inventory(Tail, Object, Tail2).

shop :-
    game_running(false),
    write('Please start the game first.'),nl,!.

shop :- 
    /* Jika player sedang tidak di tile 'K' */
    
    game_running(true),
    player_pos(X,Y),
    \+ itb(koperasi,X,Y),
    
    write('Please go to koperasi (K)!'),nl,!.

shop :-
    game_running(true),
    in_test_room(false),
    player_pos(X,Y),
    itb(koperasi,X,Y),
    
    write('What do you want to do?'), nl,
    player_semester(Sem),
    Price is round(5*(1.5**Sem)),
    format('1. Buy Mukjizat (~p gold, It replenishes your sanity!)\n', [Price]),
    write('2. Sell Equipment (50 gold)'),nl,
    write('> '),
    read(Choice),
    
    executeShop(Choice),!.

executeShop(1) :-
    player_pos(X,Y),
    itb(koperasi,X,Y),
    
    player_gold(Gold),
    player_semester(Sem),
    Price is round(5*(1.5**Sem)),
    Gold < Price,
    write('You don\'t have enough gold.'),nl,!.

executeShop(1) :-
    player_pos(X,Y),
    itb(koperasi,X,Y),
    
    player_gold(Gold),
    retract(player_gold(Gold)),
    player_semester(Sem),
    Price is round(5*(1.5**Sem)),
    New_gold is Gold-Price,
    asserta(player_gold(New_gold)),
    modify_player_inventory('Mukjizat').
    
executeShop(2) :-
    player_pos(X,Y),
    itb(koperasi,X,Y),
    
    write('Equipment:'),nl,
    player_inventory(PInventory),
    my_equipment(PInventory, Inventory),
    print_equipment(1, Inventory),!,
    length(Inventory, Length),
    N is Length+1,
    format(' ~p. Cancel', [N]),nl,
    write('> '),
    read(Choice),
    
    sellEquipment(Choice),!.

sellEquipment(Choice) :-
    player_pos(X,Y),
    itb(koperasi,X,Y),
    
    player_inventory(PInventory),
    my_equipment(PInventory, Inventory),
    Choice >= 1,
    length(Inventory, Length),
    Choice =< Length,
    Choice1 is Choice-1,
    nth0(Choice1, Inventory, Equipment),
    
    player_gold(Gold),
    New_gold is Gold+50,!,
    retract(player_gold(Gold)),
    asserta(player_gold(New_gold)),
    
    format('You sold ~p for 50 gold.\n',[Equipment]),!,
    
    delete_inventory(PInventory, Equipment, New_Inventory),
    paste_inventory(New_Inventory).

sellEquipment(Choice) :-
    player_pos(X,Y),
    itb(koperasi,X,Y),
    
    player_inventory(PInventory),
    my_equipment(PInventory, Inventory),
    length(Inventory, Length),
    N is Length+1,
    Choice = N,!.

modify_player_inventory(T) :-
    player_inventory(L),
    add_inventory(L,T,M),
    retract(player_inventory(L)),
    asserta(player_inventory(M)).