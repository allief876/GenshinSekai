/* deklarasi fakta-fakta dynamic */

:- dynamic(game_running/1).			game_running(true).
:- dynamic(in_test_room/1).         in_test_room(true).

:- dynamic(player_sanity/1).		player_sanity(70).
:- dynamic(player_intelligence/1).  player_intelligence(14).
:- dynamic(player_luck/1).          player_luck(13).
:- dynamic(player_semester/1).      player_semester(1).
:- dynamic(player_pos/2).			player_pos(0, 0).
:- dynamic(player_weapon/1).		player_weapon(kalkulator).
:- dynamic(player_gold/1).          player_gold(0).
:- dynamic(player_inventory/1).  	player_inventory([]).

:- dynamic(map_width/1).			map_width(0).
:- dynamic(map_length/1).			map_length(0).
:- dynamic(map_items/1).			map_items(0).

:- dynamic(monsters/1).				monsters(1).
:- dynamic(monster_status/5).       monster_status(praktikum, 1, 13, 15, 70).

:- dynamic(turn/1).                 turn(0).
:- dynamic(last_cheat/1).           last_cheat(0).

/* import file-file .pl untuk game */

:- include(answer).

/* run game */

start :-
    game_running(true),
    turn(0),
    retract(turn(0)),
    asserta(turn(1)),
    write('Fight!'),nl,nl.
    
player_status(P_semester, P_intelligence, P_luck, P_sanity) :-
    player_semester(P_semester),
    player_intelligence(P_intelligence),
    player_luck(P_luck),
    player_sanity(P_sanity).

player_status :-
    player_semester(P_semester),
    player_intelligence(P_intelligence),
    player_luck(P_luck),
    player_sanity(P_sanity),
    format('Semester: ~p\n', [P_semester]),
    format('Sanity: ~p\n', [P_sanity]),
    format('Intelligence: ~p\n', [P_intelligence]),
    format('Luck: ~p\n\n', [P_luck]).