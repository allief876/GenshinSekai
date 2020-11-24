/* deklarasi fakta-fakta dynamic */

:- dynamic(game_running/1).			game_running(false).
:- dynamic(in_test_room/1).         in_test_room(false).

:- dynamic(player_sanity/1).
:- dynamic(player_intelligence/1).
:- dynamic(player_luck/1).
:- dynamic(player_semester/1).
:- dynamic(fakultas/1).
:- dynamic(player_pos/2).			player_pos(0, 0).
:- dynamic(equipment/1).
:- dynamic(player_gold/1).
:- dynamic(player_inventory/1).  	player_inventory([]).

:- dynamic(map_items/1).			map_items(0).
:- dynamic(itb/3).

:- dynamic(monster_status/5).
:- dynamic(tugas_akhir_status/4).

:- dynamic(turn/1).                 turn(0).
:- dynamic(last_cheat/1).           last_cheat(0).

:- dynamic(tugas/1).                tugas([]).

/* import file-file .pl untuk game */

:- include(answer).
:- include(map).
:- include(move).
:- include(player).
:- include(sleep).

/* run game */

start :-
    game_running(false),
    retract(game_running(false)),
    asserta(game_running(true)),
    init_itb,
    init_player.
    
in_test_room(true) :- game_running(true).