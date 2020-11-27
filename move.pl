w(1) :-
    game_running(true),
    in_test_room(false),
    player_pos(Y,X),
    New_Y is Y-1,
    valid_move(New_Y, X),!,
    retract(player_pos(Y, X)),
    asserta(player_pos(New_Y, X)),
    generate_monster.

w(N) :-
    game_running(true),
    in_test_room(false),
    player_pos(Y,X),
    New_Y is Y-1,
    valid_move(New_Y, X),!,
    retract(player_pos(Y, X)),
    asserta(player_pos(New_Y, X)),
    N1 is N-1,
    generate_monster,
    w(N1).

w :-
    game_running(true),
    in_test_room(false),
    player_pos(Y,X),
    New_Y is Y-1,
    valid_move(New_Y, X),!,
    retract(player_pos(Y, X)),
    asserta(player_pos(New_Y, X)),
    generate_monster.
    
a(1) :-
    game_running(true),
    in_test_room(false),
    player_pos(Y,X),
    New_X is X-1,
    valid_move(Y, New_X),!,
    retract(player_pos(Y, X)),
    asserta(player_pos(Y, New_X)),
    generate_monster.

a(N) :-
    game_running(true),
    in_test_room(false),
    player_pos(Y,X),
    New_X is X-1,
    valid_move(Y, New_X),!,
    retract(player_pos(Y, X)),
    asserta(player_pos(Y, New_X)),
    N1 is N-1,
    generate_monster,
    a(N1).

a :-
    game_running(true),
    in_test_room(false),
    player_pos(Y,X),
    New_X is X-1,
    valid_move(Y, New_X),!,
    retract(player_pos(Y, X)),
    asserta(player_pos(Y, New_X)),
    generate_monster.
    
s(1) :-
    game_running(true),
    in_test_room(false),
    player_pos(Y,X),
    New_Y is Y+1,
    valid_move(New_Y, X),!,
    retract(player_pos(Y, X)),
    asserta(player_pos(New_Y, X)),
    generate_monster.

s(N) :-
    game_running(true),
    in_test_room(false),
    player_pos(Y,X),
    New_Y is Y+1,
    valid_move(New_Y, X),!,
    retract(player_pos(Y, X)),
    asserta(player_pos(New_Y, X)),
    N1 is N-1,
    generate_monster,
    s(N1).

s :-
    game_running(true),
    player_pos(Y,X),
    New_Y is Y+1,
    valid_move(New_Y, X),!,
    retract(player_pos(Y, X)),
    asserta(player_pos(New_Y, X)),
    generate_monster.

d(1) :-
    game_running(true),
    in_test_room(false),
    player_pos(Y,X),
    New_X is X+1,
    valid_move(Y, New_X),!,
    retract(player_pos(Y, X)),
    asserta(player_pos(Y, New_X)),
    generate_monster.
    
d(N) :-
    game_running(true),
    in_test_room(false),
    player_pos(Y,X),
    New_X is X+1,
    valid_move(Y, New_X),!,
    retract(player_pos(Y, X)),
    asserta(player_pos(Y, New_X)),
    N1 is N-1,
    generate_monster,
    d(N1).

d :-
    game_running(true),
    in_test_room(false),
    player_pos(Y,X),
    New_X is X+1,
    valid_move(Y, New_X),!,
    retract(player_pos(Y, X)),
    asserta(player_pos(Y, New_X)),
    generate_monster.
    
/* monster generation */

getType(praktikum,1).
getType(tubes,2).
getType(uts,3).
getType(uas,4).
getType(ta,5).
    
generate_monster :-
    game_running(true),
    outside,
    random(X),
    X > 0.85,!,
    
    retract(turn(0)),
    asserta(turn(1)),
    
    player_semester(P_sem),
    Sem is P_sem-1,
    
    random(1,5,T),!,
    getType(Type,T),
    
    LowerBar is round(10*(1.5**Sem)),
    UpperBar is round(15*(1.5**Sem)),
    
    random(LowerBar,UpperBar,M_atk),!,
    random(LowerBar,UpperBar,M_def),!,
    
    LowerHP is round((20+T)*(1.5**Sem)),
    UpperHP is round((25+T)*(1.5**Sem)),
    random(LowerHP,UpperHP,M_progress),!,
    
    retract(in_test_room(false)),
    asserta(in_test_room(true)),
    format('It\'s time for ~p! Entering test room...\n\n',[Type]),
    asserta(monster_status(Type, P_sem, M_atk, M_def, M_progress)),
    monster_status,!.

generate_monster.

outside :-
    player_pos(X,Y),
    \+ at_home(X,Y),
    \+ in_lab(X,Y).

at_home(0,Y) :-
    Y >= 0,
    Y < 3.

at_home(1,Y) :-
    Y >= 0,
    Y < 4.

in_lab(X,Y) :-
    X > 6,
    X < 9,
    Y > 22,
    Y < 26.

in_lab(9,Y) :-
    Y > 19,
    Y < 26.

valid_move(New_Y,New_X) :-
    New_X >= 0,
    New_Y >= 0,
    New_X < 30,
    New_Y < 20,
    \+ itb(wall,New_Y,New_X).



