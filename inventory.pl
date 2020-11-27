/* inventory */

inventory :- 
    write('Inventory:'),nl,
    show_inventory.

show_inventory :-
    player_inventory(Inventory),
    length(Inventory, Length),
    Length > 0,
    my_equipment(Inventory, Equipments),
    print_inventory(Equipments),
    print_mukjizat(Inventory),!.
    
show_inventory :-
    player_inventory(Inventory),
    length(Inventory, Length),
    Length = 0,
    write('[Your inventory is empty.]'),nl,!.

print_inventory(Inventory):- 
    Inventory = [], !.

print_inventory(Inventory):- 
    [Head|Tail] = Inventory,
    format(' - ~p\n', [Head]),
    print_inventory(Tail).

print_mukjizat(Inventory) :-
    count_inventory(Inventory, 'Mukjizat', N),
    N > 0,
    format(' - Mukjizat (x~p)\n',[N]),!.
    
print_mukjizat(Inventory) :-
    count_inventory(Inventory, 'Mukjizat', N),
    N = 0.
    
count_inventory([], _, 0).
    
count_inventory([Item|Tail], Item, N) :-
    count_inventory(Tail,Item,N1),
    N is N1+1.
    
count_inventory([Head|Tail], Item, N) :-
    Head \== Item,
    count_inventory(Tail,Item,N).

/* hapus barang dari inventory */

delete_inventory([],_,[]) :- !.

delete_inventory([Head|Tail], Object, Tail) :-
    Head == Object, !.

delete_inventory([Head|Tail], Object, [Head|Tail2]) :-
    Head \== Object,
    delete_inventory(Tail, Object, Tail2).

/* setelah hapus barang */

paste_inventory(New_inventory):-
	player_inventory(Inventory),
	retract(player_inventory(Inventory)),
	asserta(player_inventory(New_inventory)).

/* penggeladahan inventory */

search_inventory([], _, 0) :- !.

search_inventory([Head|_], Object, X) :-
    Head == Object, !,
    X is 1.

search_inventory([Head|B], Object, X) :-
    Head \== Object,
    search_inventory(B, Object, X).

