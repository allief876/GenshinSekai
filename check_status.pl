:- dynamic(player_faculty/1).       player_faculty(fish).
:- dynamic(player_semester/1).      player_semester(0).
:- dynamic(player_sanity/1).        player_sanity(0).
:- dynamic(player_max_sanity/1).    player_max_sanity(0).
:- dynamic(player_intelligence/1).  player_intelligence(0).
:- dynamic(player_luck/1).          player_luck(0).
:- dynamic(player_sks/1).           player_sks(0).
:- dynamic(player_max_sks/1).       player_max_sks(0).
:- dynamic(player_gold/1).          player_gold(0).

/* Include */
:- include(status).