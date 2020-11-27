/* File: shop.pl */
/* NIM - Nama: 13519221 - Allief Nuriman */
/* Mengunjungi & berinteraksi di shop */

/* shop */
/* Deklarasi Fakta */
:- dynamic(player_in_shop/1).        player_in_shop(false).

add_inventory([], Object, [Object]) :- !.

add_inventory([Head|Tail], Object, [Head|Tail2]) :-
    add_inventory(Tail, Object, Tail2).

shop :-
    game_running(false),
    write('Please start the game first.'),nl,!.

/*shop :- Jika player sedang tidak di tile 'K'
    game_running(true),
    player_pos(X,Y),
    itb(koperasi,X,Y),
    
    write('Ini bukan toko!'),nl,!.*/

shop :-
    game_running(true),
    /*player_pos(X,Y),
    itb(koperasi,X,Y),*/

    retract(player_in_shop(false)),
    asserta(player_in_shop(true)),
    write('What do you want to buy?'), nl,
    write('1. Mukjizat (5 gold)'), nl,
    write('Use command "potion." to buy Mukjizat (It replenishes your sanity!)'),nl.

potion :-
    player_gold(X),
    X < 5,
    write("You don't have enough gold."),nl,!.

potion :-
    player_gold(X),
    retract(player_gold(X)),
    Y is X - 5,
    asserta(player_gold(Y)),
    modify_player_inventory(mukjizat).

modify_player_inventory(T) :-
    player_inventory(L),
    add_inventory(L,T,M),
    retract(player_inventory(L)),
    asserta(player_inventory(M)).

exitShop :-
    write('Thanks for coming!'),nl,
    retract(player_in_shop(true)),
    asserta(player_in_shop(false)).