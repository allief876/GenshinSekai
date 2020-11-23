/* https://github.com/Jessinra/IF2121-Survival-game/ */

:- dynamic(usedSpace/1).
inventory(X) :- usedSpace(X).

print_inventory(Inventory):- Inventory = [], !.

print_inventory(Inventory):- [Head|Tail] = Inventory, format(" -  ~p \n", [Head]), print_inventory(Tail).
	