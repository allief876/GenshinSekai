/* File: status.pl */
/* NIM - Nama: 13519221 - Allief Nuriman */
/* Menampilkan status player */

/* status */
status :-
    game_running(false),
    write('Please start the game first.'),nl,!.

status :-

    player_sanity(Sanity),
    player_intelligence(Intelligence),
    player_semester(Semester),
    player_luck(Luck),
    player_sks(Sks),
    player_gold(Gold),
    player_faculty(Faculty),

    write('Your status:'), nl, nl,
    format('Faculty          : ~p~n',[Faculty]),
    format('Semester         : ~p~n',[Semester]),
    format('Sanity           : ~p~n',[Sanity]),
    format('Intelligence     : ~p~n',[Intelligence]),
    format('Luck             : ~p~n',[Luck]),
    format('Exp              : ~p~n',[Sks]),
    format('Gold             : ~p~n',[Gold]).