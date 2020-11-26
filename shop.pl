/* File: shop.pl */
/* NIM / Nama: 13519221 / Allief Nuriman */
/* Mengunjungi & berinteraksi di shop */

/* shop */
/* Deklarasi Fakta */
:- dynamic(player_in_shop/1).        player_in_shop(false).

/* =========== github.com/Jessinra/IF2121-Survival-game/blob/master/inventory.pl =========== */
addObj([], C, [C]) :- !.
	/* Add object to list : basis */

addObj([A|B], C, [A|D]) :- addObj(B, C, D).
	/* Add object to list : recrsive */
/* =========== */

shop :-
    game_running(false),
    write('Start dulu gamenya, koplak!'),nl,!.

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
    write('1. Mukjizat (100 gold)'), nl,
    write('Use command "potion." to buy Mukjizat (It replenish your sanity!)'),nl.

potion :-
    player_gold(X),
    X < 200,
    write('Uang tidak cukup!'),nl,!.

potion :-
    player_gold(X),
    retract(player_gold(X)),
    Y is X - 200,
    asserta(player_gold(Y)),
    modify_player_inventory(mukjizat).

modify_player_inventory(T) :-
    player_inventory(L),
    addObj(L,T,M),
    retract(player_inventory(L)),
    asserta(player_inventory(M)).