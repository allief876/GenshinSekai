/* https://github.com/Jessinra/IF2121-Survival-game/ */

/* inventory */
inventory :- 
    write('Inventory:'),nl,
    show_inventory.

/* https://github.com/Jessinra/IF2121-Survival-game/ */
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