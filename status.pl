/* File: status.pl */
/* NIM / Nama: 13519221 / Allief Nuriman */
/* Menampilkan status player */

/* status */

status :-

    player_sanity(Sanity),
    player_intelligence(Intelligence),
    player_semester(Semester),
    player_luck(Luck),
    player_sks(Sks),
    player_gold(Gold),
    player_faculty(Faculty),

    write('Your status:'), nl,
    format('Faculty          : ~p~n',[Faculty]), nl,
    format('Semester         : ~p~n',[Semester]), nl,
    format('Sanity           : ~p~n',[Sanity]), nl,
    format('Intelligence     : ~p~n',[Intelligence]), nl,
    format('Luck             : ~p~n',[Luck]), nl,
    format('Exp              : ~p~n',[Sks]), nl,
    format('Gold             : ~p~n',[Gold]), nl.