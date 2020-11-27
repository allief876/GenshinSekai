/* assignments(N_Praktikum, N_Tubes, N_UTS, N_UAS).
   player_progress(N_Praktikum, N_Tubes, N_UTS, N_UAS). */

/* assign tugas per semester, diambil di T */

assign :-
    /* semester 1 */
    
    player_pos(X,Y),
    itb(tugas,X,Y),
    player_semester(P_semester),
    P_semester == 1, !,
    retract(assigns_finished(_)),
    asserta(assigns_finished(false)),
    \+ assignments(_,_,_,_),
    asserta(assignments(2,0,1,1)), !,
    write('New tasks:'),nl,nl,
    write('Praktikum        : 2'),nl,
    write('Tubes            : 0'),nl,
    write('UTS              : 1'),nl,
    write('UAS              : 1'),nl,!.

assign :-
    /* semester 2 */
    
    player_pos(X,Y),
    itb(tugas,X,Y),
    player_semester(P_semester),
    P_semester == 2, !,
    retract(assigns_finished(_)),
    asserta(assigns_finished(false)),
    \+ assignments(_,_,_,_),
    asserta(assignments(3,0,1,1)), !,
    write('New tasks:'),nl,nl,
    write('Praktikum        : 3'),nl,
    write('Tubes            : 0'),nl,
    write('UTS              : 1'),nl,
    write('UAS              : 1'),nl,!.

assign :-
    /* semester 3 */
    
    player_pos(X,Y),
    itb(tugas,X,Y),
    player_semester(P_semester),
    P_semester == 3, !,
    retract(assigns_finished(_)),
    asserta(assigns_finished(false)),
    \+ assignments(_,_,_,_),
    asserta(assignments(3,1,1,1)), !,
    write('New tasks:'),nl,nl,
    write('Praktikum        : 3'),nl,
    write('Tubes            : 1'),nl,
    write('UTS              : 1'),nl,
    write('UAS              : 1'),nl,!.

assign :-
    /* semester 4 */
    
    player_pos(X,Y),
    itb(tugas,X,Y),
    player_semester(P_semester),
    P_semester == 4, !,
    retract(assigns_finished(_)),
    asserta(assigns_finished(false)),
    \+ assignments(_,_,_,_),
    asserta(assignments(3,1,1,1)), !,
    write('New tasks:'),nl,nl,
    write('Praktikum        : 3'),nl,
    write('Tubes            : 1'),nl,
    write('UTS              : 1'),nl,
    write('UAS              : 1'),nl,!.

assign :-
    /* semester 5 */
    
    player_pos(X,Y),
    itb(tugas,X,Y),
    player_semester(P_semester),
    P_semester == 5, !,
    retract(assigns_finished(_)),
    asserta(assigns_finished(false)),
    \+ assignments(_,_,_,_),
    asserta(assignments(3,2,1,1)), !,
    write('New tasks:'),nl,nl,
    write('Praktikum        : 3'),nl,
    write('Tubes            : 2'),nl,
    write('UTS              : 1'),nl,
    write('UAS              : 1'),nl,!.

assign :-
    /* semester 6 */
    
    player_pos(X,Y),
    itb(tugas,X,Y),
    player_semester(P_semester),
    P_semester == 6, !,
    retract(assigns_finished(_)),
    asserta(assigns_finished(false)),
    \+ assignments(_,_,_,_),
    asserta(assignments(3,2,1,1)), !,
    write('New tasks:'),nl,nl,
    write('Praktikum        : 3'),nl,
    write('Tubes            : 2'),nl,
    write('UTS              : 1'),nl,
    write('UAS              : 1'),nl,!.

assign :-
    /* semester 7 */
    
    player_pos(X,Y),
    itb(tugas,X,Y),
    player_semester(P_semester),
    P_semester == 7, !,
    retract(assigns_finished(_)),
    asserta(assigns_finished(false)),
    \+ assignments(_,_,_,_),
    asserta(assignments(3,3,1,1)), !,
    write('New tasks:'),nl,nl,
    write('Praktikum        : 3'),nl,
    write('Tubes            : 3'),nl,
    write('UTS              : 1'),nl,
    write('UAS              : 1'),nl,!.

assign :-
    /* semester 8 */
    
    player_pos(X,Y),
    itb(tugas,X,Y),
    player_semester(P_semester),
    P_semester == 8, !,
    retract(assigns_finished(_)),
    asserta(assigns_finished(false)),
    \+ assignments(_,_,_,_),
    asserta(assignments(2,2,1,1)), !,
    write('New tasks:'),nl,nl,
    write('Praktikum        : 2'),nl,
    write('Tubes            : 2'),nl,
    write('UTS              : 1'),nl,
    write('UAS              : 1'),nl,!.

assign :-
    /* semester > 8 */
    
    player_pos(X,Y),
    itb(tugas,X,Y),
    player_semester(P_semester),
    P_semester > 8, !,
    
    write('No tasks left to do. Go finish your Final Assignment!'),nl,!.
    
    
assign :-
    /* saat tidak di petak T */
    
    game_running(true),
    player_pos(X,Y),
    \+ itb(tugas,X,Y),
    write('Pick up your assignments at Tugas (T)!'),nl,!.
    
assign :-
    game_running(false),
    
    write('Please start the game first.'),nl,!.

/* tambah progress assignment setiap mengalahkan enemy */

add_progress(praktikum) :-
    /* monster tipe prak kalah */
    
    player_progress(N_Praktikum, N_Tubes, N_UTS, N_UAS),
    New_prak is N_Praktikum + 1,
    New_tubes is N_Tubes,
    New_uts is N_UTS,
    New_uas is N_UAS,
    retract(player_progress(_,_,_,_)),
    asserta(player_progress(New_prak, New_tubes, New_uts, New_uas)), !.

add_progress(tubes) :-
    /* monster tipe tubes kalah */
    
    player_progress(N_Praktikum, N_Tubes, N_UTS, N_UAS),
    New_tubes is N_Tubes + 1,
    New_prak is N_Praktikum,
    New_uts is N_UTS,
    New_uas is N_UAS,
    retract(player_progress(_,_,_,_)),
    asserta(player_progress(New_prak, New_tubes, New_uts, New_uas)), !.

add_progress(uts) :-
    /* monster tipe uts kalah */
    
    player_progress(N_Praktikum, N_Tubes, N_UTS, N_UAS),
    New_uts is N_UTS + 1,
    New_tubes is N_Tubes,
    New_prak is N_Praktikum,
    New_uas is N_UAS,
    retract(player_progress(_,_,_,_)),
    asserta(player_progress(New_prak, New_tubes, New_uts, New_uas)), !.

add_progress(uas) :-
    /* monster tipe uas kalah */
    
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
    IsFinished == false,

    assignments(N_Praktikum, N_Tubes, N_UTS, N_UAS),
    retract(assignments(N_Praktikum, N_Tubes, N_UTS, N_UAS)),
    player_progress(P_Praktikum, P_Tubes, P_UTS, P_UAS),
    P_Praktikum >= N_Praktikum,!,
    P_Tubes >= N_Tubes,!,
    P_UTS >= N_Tubes,!,
    P_UAS >= N_UAS,!,

    retract(assigns_finished(_)),
    asserta(assigns_finished(true)),
    write('You have finished your assignments!'), nl,

    player_gold(Gold),
    player_semester(P_semester),
    Add_gold is P_semester*50,
    New_gold is Gold + P_semester,
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
    IsFinished == false,

    assignments(N_Praktikum, N_Tubes, N_UTS, N_UAS),
    player_progress(P_Praktikum, P_Tubes, P_UTS, P_UAS),
    P_Praktikum < N_Praktikum,
    P_Tubes < N_Tubes,
    P_UTS < N_Tubes,
    P_UAS < N_UAS,!.
    
finish_assignments.

/* pengecekan apakah sks sudah terpenuhi */

naik_semester :-
    /* sks belum cukup */
    game_running(true),
    
    player_sks(SKS),
    SKS < 18, !.

naik_semester :-
    /* sks cukup */
    game_running(true),
    
    player_sks(SKS),
    SKS >= 18, !,
    player_semester(P_semester),
    format('You have passed Semester ~p!\n',[P_semester]),
    
    player_sks(P_sks),
    New_sks is P_sks-18,
    retract(player_sks(_)),
    asserta(player_sks(New_sks)),
    
    retract(assigns_finished(_)),
    asserta(assigns_finished(false)),

    New_semester is P_semester + 1,
    retract(player_semester(P_semester)),
    asserta(player_semester(New_semester)),
    
    player_intelligence(P_intelligence),
    player_luck(P_luck),
    player_max_sanity(P_max_sanity),
    New_P_intelligence is round(P_intelligence*1.5),
    New_P_luck is round(P_luck*1.5),
    New_P_max_sanity is round(P_max_sanity*1.5),
    retract(player_intelligence(P_intelligence)),
    retract(player_luck(P_luck)),
    retract(player_sanity(_)),
    retract(player_max_sanity(P_max_sanity)),
    asserta(player_intelligence(New_P_intelligence)),
    asserta(player_luck(New_P_luck)),
    asserta(player_sanity(New_P_max_sanity)),
    asserta(player_max_sanity(New_P_max_sanity)),
    
    format('Welcome to Semester ~p.\n',[New_semester]), 
    write('Don\'t forget to pick up your new assignments at Tugas (T)!.'),nl,!.
    
