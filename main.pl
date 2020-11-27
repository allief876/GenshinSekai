/*** ============= DEKLARASI FAKTA DINAMIS ============= ***/

:- dynamic(game_running/1).         game_running(false).

/* Fakta terkait status player */
:- dynamic(player_faculty/1).       player_faculty(fish).
:- dynamic(player_semester/1).      player_semester(0).
:- dynamic(player_sanity/1).        player_sanity(0).
:- dynamic(player_max_sanity/1).    player_max_sanity(0).
:- dynamic(player_intelligence/1).  player_intelligence(0).
:- dynamic(player_luck/1).          player_luck(0).
:- dynamic(player_sks/1).           player_sks(0).
:- dynamic(player_max_sks/1).       player_max_sks(0).
:- dynamic(player_gold/1).          player_gold(0).

/* Inventaris pemain */
:- dynamic(player_inventory/1).     player_inventory([]).

:- dynamic(equipment/1).            equipment('Bare hands').
:- dynamic(equipmentObj/4).

/* Fakta terkait map */
:- dynamic(player_pos/2).			player_pos(0,0).
:- dynamic(itb/3).

/* Fakta terkait battle */
:- dynamic(monster_status/5).
:- dynamic(tugas_akhir_status/4).
:- dynamic(in_test_room/1).         in_test_room(false).
:- dynamic(turn/1).                 turn(0).
:- dynamic(last_cheat/1).           last_cheat(0).
:- dynamic(prayed/1).

/* Fakte terkait tugas dan sks */
:- dynamic(assignments/4).          assignments(0,0,0,0).
:- dynamic(player_progress/4).      player_progress(0,0,0,0).
:- dynamic(assigns_finished/1).     assigns_finished(false).

/*** ============= INCLUDE OTHER FILE ============= ***/

:- include(inventory).
:- include(help).
:- include(map).
:- include(player).
:- include(battle).
:- include(sleep).
:- include(save_load).
:- include(shop).
:- include(move).
:- include(pray).
:- include(assign).
:- include(exit).
:- include(equipment).

/* run game */

start :-
    init_player,
    init_itb,
    init_equipments,
    game_running(false),
    retract(game_running(false)),
    asserta(game_running(true)).

game_over :-
    game_running(true),
    in_test_room(true),
    
    retract(monster_status(_, _, _, _, _)),
    retract(player_sanity(_)),
    asserta(player_sanity(0)),
    retract(in_test_room(true)),
    asserta(in_test_room(false)),
    retract(game_running(true)),
    asserta(game_running(false)),
    
    retract(turn(_)),
    asserta(turn(0)),
    retract(last_cheat(_)),
    asserta(last_cheat(0)),
    retract(prayed(_)),!,
    
    write('\nDue to stressful exams and deadlines, your sanity has dropped to 0.'),nl,nl,
    write('You have dropped out of itb!'),nl.