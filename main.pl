/*** ============= DEKLARASI FAKTA DINAMIS ============= ***/

:- dynamic(game_running/1).         game_running(false).

/* Fakta terkait status player */
:- dynamic(player_faculty).         player_faculty(fish).
:- dynamic(player_semester/1).      player_semester(0).
:- dynamic(player_sanity/1).        player_sanity(0).
:- dynamic(player_intelligence/1).  player_intelligence(0).
:- dynamic(player_luck/1).          player_luck(0).
:- dynamic(player_sks/1).           player_sks(0).
:- dynamic(player_gold).            player_gold(0).

/* Fakta tentang posisi player */
:- dynamic(player_pos/2).			player_pos(0,0).

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