init_equipments :-
    game_running(false),
    
    /* equipment all */
    
    !,asserta(equipmentObj('Bare hands', 'STEI', 1, 1)),
    asserta(equipmentObj('Bare hands', 'FMIPA', 1, 1)),
    asserta(equipmentObj('Bare hands', 'FTTM', 1, 1)),
    
    /* equipment STEI */
    
    asserta(equipmentObj('Arsip TPB', 'STEI', 1.02, 1)),
    asserta(equipmentObj('Buku Codemy', 'STEI', 1.04, 1)),
    asserta(equipmentObj('TensorFlow', 'STEI', 1.1, 1)),
    asserta(equipmentObj('Laptop', 'STEI', 1.08, 1)),
    asserta(equipmentObj('Email STD', 'STEI', 1, 1.15)),
    asserta(equipmentObj('Github', 'STEI', 1, 1.1)),
    
    /* equipment FMIPA */
    
    asserta(equipmentObj('Penggaris', 'FMIPA', 1.02, 1)),
    asserta(equipmentObj('Busur derajat', 'FMIPA', 1.04, 1)),
    asserta(equipmentObj('Kalkulator', 'FMIPA', 1.08, 1)),
    asserta(equipmentObj('Matlab', 'FMIPA', 1, 1.1)),
    asserta(equipmentObj('Textbook Wiley', 'FMIPA', 1.04, 1)),
    asserta(equipmentObj('Textbook Purcell', 'FMIPA', 1, 1.17)),
    
    /* equipment FTTM */
    
    asserta(equipmentObj('Jaket angkatan', 'FTTM', 1, 1.05)),
    asserta(equipmentObj('Barometer', 'FTTM', 1.02, 1)),
    asserta(equipmentObj('Helm tambang', 'FTTM', 1, 1.1)),
    asserta(equipmentObj('Jaket himpunan', 'FTTM', 1, 1.15)),
    asserta(equipmentObj('Workshop', 'FTTM', 1.05, 1)),
    asserta(equipmentObj('Panduan lab', 'FTTM', 1.08, 1)).
    
equipmentList(['Arsip TPB', 'Buku Codemy', 'TensorFlow', 'Laptop', 'Email STD', 'Github', 'Penggaris', 'Busur derajat', 'Kalkulator', 'Matlab', 'Textbook Wiley', 'Textbook Purcell', 'Jaket angkatan', 'Barometer', 'Helm tambang', 'Jaket himpunan', 'Workshop', 'Panduan lab']).

choose([], []).
choose(List, Elt) :-
    length(List, Length),
    random(0, Length, Index),
    nth0(Index, List, Elt).

randomEquipment(New_Equipment) :-
    equipmentList(ListEquipment),!,
    choose(ListEquipment, New_Equipment).
    
randomEquipment.

equip :-
    /* memakai equipment */
    
    equipment,
    write('> '),
    read(Choice),
    
    chooseEquipment(Choice),!.
    
chooseEquipment(Choice) :-
    equipment('Bare hands'),!,
    player_inventory(PInventory),
    my_equipment(PInventory, Inventory),
    Choice >= 1,
    length(Inventory, Length),
    Choice =< Length,
    nth0(Choice, Inventory, Equipment),
    
    player_faculty(P_faculty),
    equipmentObj(Equipment, P_faculty, _, _),
    retract(equipment('Bare hands')),
    asserta(equipment(Equipment)),
    
    delete_inventory(PInventory, Equipment, New_Inventory),
    paste_inventory(New_Inventory).
    
chooseEquipment(Choice) :-
    equipment('Bare hands'),!,
    player_inventory(PInventory),
    my_equipment(PInventory, Inventory),
    Choice >= 1,
    length(Inventory, Length),
    Choice =< Length,
    nth0(Choice, Inventory, Equipment),
    
    player_faculty(P_faculty),
    equipmentObj(Equipment, E_faculty, _, _),
    P_faculty \== E_faculty,
    format('\nUnable to equip (you can only use equipment from ~p).\n',[P_faculty]),!.

chooseEquipment(Choice) :-
    equipment(Curr_Equipment),
    Curr_Equipment \== 'Bare hands',
    player_inventory(PInventory),
    my_equipment(PInventory, Inventory),
    Choice >= 1,
    length(Inventory, Length),
    Choice =< Length,
    Choice1 is Choice-1,
    nth0(Choice1, Inventory, Equipment),
    
    player_faculty(P_faculty),
    equipmentObj(Equipment, P_faculty, _, _),
    retract(equipment(Curr_Equipment)),
    asserta(equipment(Equipment)),
    
    delete_inventory(PInventory, Equipment, New_Inventory),
    paste_inventory(New_Inventory),
    
    modify_player_inventory(Curr_Equipment).
    
chooseEquipment(Choice) :-
    equipment(Curr_Equipment),
    Curr_Equipment \== 'Bare hands',
    player_inventory(PInventory),
    my_equipment(PInventory, Inventory),
    Choice >= 1,
    length(Inventory, Length),
    Choice =< Length,
    Choice1 is Choice-1,
    nth0(Choice1, Inventory, Equipment),
    
    player_faculty(P_faculty),
    equipmentObj(Equipment, E_faculty, _, _),
    P_faculty \== E_faculty,
    format('\nUnable to equip (you can only use equipment from ~p).\n',[P_faculty]),!.

unequip :-
    equipment(Curr_Equipment),!,
    retract(equipment(Curr_Equipment)),
    asserta(equipment('Bare hands')),
    
    player_inventory(Inventory),
    
    modify_player_inventory(Curr_Equipment).
        
equipment :-
    write('Equipment:'),nl,
    player_inventory(PInventory),
    my_equipment(PInventory, Inventory),
    print_equipment(1, Inventory),!,
    equipment(Curr_Equipment),
    
    equipmentObj(Curr_Equipment, _, P_int_mul, P_luck_mul),
    player_intelligence(P_intelligence),
    player_luck(P_luck),
    P_int_use is P_intelligence*P_int_mul,
    P_luck_use is P_luck*P_luck_mul,
    
    P_int_add is P_int_use-P_intelligence,
    P_luck_add is P_luck_use-P_luck,
    
    format('\nIn use: ~p (Base Int +~2f, Base Luck +~2f)\n', [Curr_Equipment, P_int_add, P_luck_add]),!.

my_equipment([], []) :-
    !.

my_equipment([InvHead|InvTail], [InvHead|EquipTail]) :-
    equipmentObj(InvHead,_,_,_),
    my_equipment(InvTail,EquipTail).
    
my_equipment([InvHead|InvTail], Equip) :-
    \+ equipmentObj(InvHead,_,_,_),
    my_equipment(InvTail, Equip).

print_equipment(_, Inventory):- 
    Inventory = [], !.

print_equipment(N, Inventory):- 
    [Head|Tail] = Inventory,
    
    player_intelligence(P_intelligence),
    player_luck(P_luck),
    equipmentObj(Head, P_faculty, P_int_mul1, P_luck_mul1),
    equipment(Curr_Equipment),
    equipmentObj(Curr_Equipment, _, P_int_mul2, P_luck_mul2),
    P_int_use is P_intelligence*P_int_mul1,
    P_luck_use is P_luck*P_luck_mul1,
    
    P_int_curr is P_intelligence*P_int_mul2,
    P_luck_curr is P_luck*P_luck_mul2,
    
    P_int_add is P_int_use-P_int_curr,
    P_luck_add is P_luck_use-P_luck_curr,
    
    format(" ~p. ~p ~p (Int +~2f, Luck +~2f)\n", [N, Head, P_faculty, P_int_add, P_luck_add]),
    N1 is N+1,
    print_equipment(N1, Tail),!.