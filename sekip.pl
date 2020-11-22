randomizer(X, A, B) :- random(R), X is floor(A+(B-A+1)*R).
/* https://www.swi-prolog.org/pldoc/doc_for?object=random/1 */

sekip :- randomizer(X, 1, 2), sekip(X).

sekip(X) :- X=1, retract(assign), write('Kamu sekip tanpa ketahuan'), nl,!.
sekip(X) :- X=2, write('Kamu dicariin dosen ke kosan kamu!'), nl, assign.