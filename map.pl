map_width(30).
map_height(20).

/*
---#--------------------------
-H----------------------------
####--------------------------
------------------------------
#############-----############
------------------------------
----------------------#####---
-----K----------------#---#---
--------------------###-L-#---
--------------------------#---
--------------------#######---
------------------------------
--##########------##########--
--#--------#------#--------#--
--#--------#------#--------#--
--#---T----#------#--------#--
--#------------------------#--
--#--------#------#--------#--
--##########------##########--
------------------------------
*/

init_itb :- 
    map_height(R),
    init_itb_row(R),
    init_walls,
    init_locations.
    
init_itb_row(-1) :- !.
    /* basis */

init_itb_row(R) :-
    map_width(C),
	init_blank_map(R, 0, C),!,
	New_R is R-1,
	init_itb_row(New_R).
	
init_blank_map(_,_,0):- !.
	/* basis */
	
init_blank_map(R, C, Progress):-
	/* recursive */

	map_height(H), R =< H,
	map_width(W), C =< W,
	
	New_C is C+1,
	New_Progress is Progress-1,
	asserta(itb(blank, R, C)),!,

	init_blank_map(R, New_C, New_Progress),!.
	
init_walls :-
    create_kos,
    create_gerbang(4,0),
    create_lab(6,22),
    create_buildings(12,0).
    
init_locations :-
    itb(Type,1,1),
    asserta(itb(kos,1,1)),
    retract(itb(Type,1,1)),
    
    itb(Type,7,5),
    asserta(itb(koperasi,7,5)),
    retract(itb(Type,7,5)),
    
    itb(Type,8,24),
    asserta(itb(lab,8,24)),
    retract(itb(Type,8,24)),
    
    itb(Type,15,6),
    asserta(itb(tugas,15,6)),
    retract(itb(Type,15,6)).

/* create kos */

create_kos :-
    asserta(itb(wall, 2, 0)),
    retract(itb(blank, 2, 0)),
    asserta(itb(wall, 2, 1)),
    retract(itb(blank, 2, 1)),
    asserta(itb(wall, 2, 2)),
    retract(itb(blank, 2, 2)),
    asserta(itb(wall, 2, 3)),
    retract(itb(blank, 2, 3)),
    
    asserta(itb(wall, 0, 3)),
    retract(itb(blank, 0, 3)).

/* create gerbang */

create_gerbang(_,30) :-
    /* end gerbang */
    !.

create_gerbang(R,C) :-
    C < 13,!,
    
    asserta(itb(wall, R, C)),
    retract(itb(blank, R, C)),
    
    New_C is C+1,
    create_gerbang(R,New_C).
    
create_gerbang(R,C) :-
    C > 12,
    C < 17,!,
    
    New_C is C+1,
    create_gerbang(R,New_C).
    
create_gerbang(R,C) :-
    C > 16,!,
    
    asserta(itb(wall, R, C)),
    retract(itb(blank, R, C)),
    
    New_C is C+1,
    create_gerbang(R,New_C).

/* create lab */

create_lab(10,27) :-
    /* end lab */
    !.

create_lab(6,C) :-
    C < 27,!,
    asserta(itb(wall, 6, C)),
    retract(itb(blank, 6, C)),
    
    New_C is C+1,
    create_lab(6,New_C).

create_lab(6,27) :-
    !,asserta(itb(wall, 7, 22)),
    retract(itb(blank, 7, 22)),
    asserta(itb(wall, 7, 26)),
    retract(itb(blank, 7, 26)),
    
    asserta(itb(wall, 8, 20)),
    retract(itb(blank, 8, 20)),
    asserta(itb(wall, 8, 21)),
    retract(itb(blank, 8, 21)),
    asserta(itb(wall, 8, 22)),
    retract(itb(blank, 8, 22)),
    
    asserta(itb(wall, 8, 26)),
    retract(itb(blank, 8, 26)),
    
    asserta(itb(wall, 9, 26)),
    retract(itb(blank, 9, 26)),
    
    create_lab(10,20).
    
create_lab(10,C) :-
    C < 27,!,
    
    asserta(itb(wall, 10, C)),
    retract(itb(blank, 10, C)),
    
    New_C is C+1,
    create_lab(10,New_C).
    
/* create buildings */

create_buildings(19, _) :- 
    /* basis atau end create_buildings */
    !.

create_buildings(R, 29) :-
    /* rekursif, lanjut ke baris berikutnya */
    
    New_R is R+1,!,
    create_buildings(New_R, 0).
    
create_buildings(12, C) :-
    /* row = 12, gedung kiri */
    
    C > 1,
    C < 12,!,
    New_C is C+1,
    asserta(itb(wall, 12, C)),
    retract(itb(blank, 12, C)),
    create_buildings(12, New_C).
    
create_buildings(12, C) :-
    /* row = 12, gedung kanan */
    
    C > 17,
    C < 28,!,
    New_C is C+1,
    asserta(itb(wall, 12, C)),
    retract(itb(blank, 12, C)),
    create_buildings(12, New_C).
    
create_buildings(12, C) :-
    /* row = 12, bukan tembok */
    
    New_C is C+1,!,
    create_buildings(12, New_C).
    
create_buildings(18, C) :-
    /* row = 18, gedung kiri */
    
    C > 1,
    C < 12,!,
    New_C is C+1,
    asserta(itb(wall, 18, C)),
    retract(itb(blank, 18, C)),
    create_buildings(18, New_C).
    
create_buildings(18, C) :-
    /* row = 18, gedung kanan */
    
    C > 17,
    C < 28,!,
    New_C is C+1,
    asserta(itb(wall, 18, C)),
    retract(itb(blank, 18, C)),
    create_buildings(18, New_C).
    
create_buildings(18, C) :-
    /* row = 18, bukan tembok */
    
    New_C is C+1,!,
    create_buildings(18, New_C).
    
create_buildings(16,_) :-
    /* row = 16 */
    
    !,asserta(itb(wall, 16, 2)),
    retract(itb(blank, 16, 2)),
    asserta(itb(wall, 16, 27)),
    retract(itb(blank, 16, 27)),
    
    create_buildings(17, 0).
    
create_buildings(R,_) :-
    /* row antara 12 dan 18 */
    
    R > 12,
    R < 18,!,
    
    asserta(itb(wall, R, 2)),
    retract(itb(blank, R, 2)),
    asserta(itb(wall, R, 11)),
    retract(itb(blank, R, 11)),
    asserta(itb(wall, R, 18)),
    retract(itb(blank, R, 18)),
    asserta(itb(wall, R, 27)),
    retract(itb(blank, R, 27)),
    
    New_R is R+1,
    create_buildings(New_R, 0).

/* print map */

print_tile(19,29) :- 
    printchar(Char, 19, 29),!,
    format('~p',[Char]),
    write('#'),nl.
    
print_tile(R,29) :-
    New_R is R+1,
    printchar(Char, R, 29),!,
    format('~p',[Char]),
    write('#'),nl,
    print_tile(New_R,0).
    
print_tile(R,0) :-
    printchar(Char, R, 0),!,
    write('#'),
    format('~p',[Char]),
    print_tile(R, 1).

print_tile(R,C) :-
    New_C is C+1,
    printchar(Char, R, C),!,
    format('~p',[Char]),
    print_tile(R, New_C).

map:-
    game_running(true),
    print_border(0),
    print_tile(0,0),
    print_border(0),!.
    
print_border(0) :-
    write('#'),!,
    print_border(1).

print_border(N) :-
    map_width(W),
    W_Next is W+1,
    W_Next = N,
    write('#'),nl,!.

print_border(N) :-
    write('#'),!,
    New_N is N+1,
    print_border(New_N).
    
/* cari karakter untuk diprint */

printchar('P', R, C) :-
    player_pos(R,C),!.

printchar('-', R, C) :-
    itb(blank, R, C).

printchar('#', R, C) :-
    itb(wall, R, C).

printchar('H', R, C) :-
    itb(kos, R, C).

printchar('K', R, C) :-
    itb(koperasi, R, C).

printchar('L', R, C) :-
    itb(lab, R, C).

printchar('T', R, C) :-
    itb(tugas, R, C).