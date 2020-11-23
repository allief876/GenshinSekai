/*** ============= DEKLARASI FAKTA DINAMIS ============= ***/

:- dynamic(game_running/1).        game_running(false).

:- dynamic(sanity/1).              sanity(0).
:- dynamic(intelligence/1).        intelligence(0).
:- dynamic(inventory/1).           inventory([]).
:- dynamic(inventory_length/1).    inventory_length(0).
:- dynamic(semester/1).            semester(0).
:- dynamic(equipment/1).           equipment(0).
:- dynamic(fakultas/1).            fakultas(NULL).
:- dynamic(luck/1).                luck(0).
:- dynamic(enemy/1).               enemy(NULL).
:- dynamic(enemy_semester/1).      enemy_semester(0).
:- dynamic(enemy_progress/1).      enemy_progress(0).
:- dynamic(enemy_attack/1).        enemy_attack(0).
:- dynamic(enemy_defence/1).       enemy_defence(1).
:- dynamic(tugas/1).               tugas([]).

/*** ============= INCLUDE OTHER FILE ============= ***/

:- include(start).
:- include(inventory).
:- include(sekip).
:- include(help).
:- include(map).
:- include(answer).
:- include(sleep).
:- include(save).
:- include(status).
:- include(cheat).
:- include(shop).
:- include(load).
:- include(gerak).
:- include(pray).
:- include(assign).
:- include(exit).