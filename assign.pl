/* assignments(N_Praktikum, N_Tubes, N_UTS, N_UAS).
   player_progress(N_Praktikum, N_Tubes, N_UTS, N_UAS). */

/* assign tugas per semester, diambil di Quest */

assign :-
    /* semester 1 */
    player_semester(P_semester),
    P_semester == 1, !,
    retract(assigns_finished(_)),
    asserta(assigns_finished(false)),
    retract(assignments(_,_,_,_)),
    asserta(assignments(2,0,1,1)), !.

assign :-
    /* semester 2 */
    player_semester(P_semester),
    P_semester == 2, !,
    retract(assigns_finished(_)),
    asserta(assigns_finished(false)),
    retract(assignments(_,_,_,_)),
    asserta(assignments(3,0,1,1)), !.

assign :-
    /* semester 3 */
    player_semester(P_semester),
    P_semester == 3, !,
    retract(assigns_finished(_)),
    asserta(assigns_finished(false)),
    retract(assignments(_,_,_,_)),
    asserta(assignments(3,1,1,1)), !.

assign :-
    /* semester 4 */
    player_semester(P_semester),
    P_semester == 4, !,
    retract(assigns_finished(_)),
    asserta(assigns_finished(false)),
    retract(assignments(_,_,_,_)),
    asserta(assignments(3,1,1,1)), !.

assign :-
    /* semester 5 */
    player_semester(P_semester),
    P_semester == 5, !,
    retract(assigns_finished(_)),
    asserta(assigns_finished(false)),
    retract(assignments(_,_,_,_)),
    asserta(assignments(3,2,1,1)), !.

assign :-
    /* semester 6 */
    player_semester(P_semester),
    P_semester == 6, !,
    retract(assigns_finished(_)),
    asserta(assigns_finished(false)),
    retract(assignments(_,_,_,_)),
    asserta(assignments(3,2,1,1)), !.

assign :-
    /* semester 7 */
    player_semester(P_semester),
    P_semester == 7, !,
    retract(assigns_finished(_)),
    asserta(assigns_finished(false)),
    retract(assignments(_,_,_,_)),
    asserta(assignments(3,3,1,1)), !.

assign :-
    /* semester 8 */
    player_semester(P_semester),
    P_semester == 8, !,
    retract(assigns_finished(_)),
    asserta(assigns_finished(false)),
    retract(assignments(_,_,_,_)),
    asserta(assignments(2,2,1,1)), !.

/* tambah progress assignment setiap mengalahkan enemy */

add_progress(M_type) :-
    /* monster tipe prak kalah */
    M_type == 1, !,
    player_progress(N_Praktikum, N_Tubes, N_UTS, N_UAS),
    New_prak is N_Praktikum + 1,
    New_tubes is N_Tubes,
    New_uts is N_UTS,
    New_uas is N_UAS,
    retract(player_progress(_,_,_,_)),
    asserta(player_progress(New_prak, New_tubes, New_uts, New_uas)), !.

add_progress(M_type) :-
    /* monster tipe tubes kalah */
    M_type == 2, !,
    player_progress(N_Praktikum, N_Tubes, N_UTS, N_UAS),
    New_tubes is N_Tubes + 1,
    New_prak is N_Praktikum,
    New_uts is N_UTS,
    New_uas is N_UAS,
    retract(player_progress(_,_,_,_)),
    asserta(player_progress(New_prak, New_tubes, New_uts, New_uas)), !.

add_progress(M_type) :-
    /* monster tipe uts kalah */
    M_type == 3, !,
    player_progress(N_Praktikum, N_Tubes, N_UTS, N_UAS),
    New_uts is N_UTS + 1,
    New_tubes is N_Tubes,
    New_prak is N_Praktikum,
    New_uas is N_UAS,
    retract(player_progress(_,_,_,_)),
    asserta(player_progress(New_prak, New_tubes, New_uts, New_uas)), !.

add_progress(M_type) :-
    /* monster tipe uas kalah */
    M_type == 4, !,
    player_progress(N_Praktikum, N_Tubes, N_UTS, N_UAS),
    New_uas is N_UAS + 1,
    New_tubes is N_Tubes,
    New_uts is N_UTS,
    New_prak is N_Praktikum,
    retract(player_progress(_,_,_,_)),
    asserta(player_progress(New_prak, New_tubes, New_uts, New_uas)), !.

/* pengecekan apakah assignments sudah terpenuhi */

finish_assignments :-
    /* tugas cukup */
    assigns_finished(IsFinished),
    IsFinished == false, !,

    assignments(N_Praktikum, N_Tubes, N_UTS, N_UAS),
    player_progress(P_Praktikum, P_Tubes, P_UTS, P_UAS),
    P_Praktikum >= N_Praktikum, !,
    P_Tubes >= N_Tubes, !,
    P_UTS >= N_Tubes, !,
    P_UAS >= N_UAS, !,

    retract(assigns_finished(_)),
    asserta(assigns_finished(true)),
    write('You have finished your assignments!'), nl,

    player_gold(Gold),
    New_gold is Gold + 100,
    retract(player_gold(Gold)),
    asserta(player_gold(New_gold)),
    player_sks(SKS),
    New_sks is SKS + 10,
    retract(player_sks(SKS)),
    asserta(player_sks(New_sks)),
    write('You get 100 gold and 10 SKS.'), nl, !.

finish_assignments :-
    /* tugas belum cukup */
    assigns_finished(IsFinished),
    IsFinished == false, !,

    assignments(N_Praktikum, N_Tubes, N_UTS, N_UAS),
    player_progress(P_Praktikum, P_Tubes, P_UTS, P_UAS),
    P_Praktikum < N_Praktikum, !,
    P_Tubes < N_Tubes, !,
    P_UTS < N_Tubes, !,
    P_UAS < N_UAS, !.

/* pengecekan apakah sks sudah terpenuhi */

naik_semester :-
    /* sks belum cukup */
    player_sks(SKS),
    SKS < 18, !.

naik_semester :-
    /* sks cukup */
    player_sks(SKS),
    SKS >= 18, !,
    player_semester(P_semester),
    format('You have passed Semester ~p!\n',[P_semester]),

    player_sks(_),
    New_sks is 0,
    retract(player_sks(_)),
    asserta(player_sks(New_sks)),

    assigns_finished(_),
    New_finished is false,
    retract(player_sks(_)),
    asserta(player_sks(New_finished)),

    New_semester is P_semester + 1,
    retract(player_semester(P_semester)),
    asserta(player_semester(New_semester)),
    format('Welcome to Semester ~p.\n',[New_semester]), !.
    
