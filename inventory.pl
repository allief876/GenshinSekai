/* inventory */

inventory :- 
    write('Inventory:'),nl,
    show_inventory.

show_inventory :-
    player_inventory(Inventory),
    print_inventory(Inventory),
    equipment(Equipment),
    format(" - ~p \n ", [Equipment]),nl.

print_inventory(Inventory):- 
    Inventory = [], !.

print_inventory(Inventory):- 
    [Head|Tail] = Inventory,
    format(" -  ~p \n", [Head]),
    print_inventory(Tail).

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

