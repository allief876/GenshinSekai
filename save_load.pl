/* Mekanisme save dan load */

load_game(Filename):-
	/* Function to load file */
	
	open(Filename, read, Stream),

	player_sanity(Sanity), 
	player_max_sanity(Max_Sanity),
	player_luck(Luck), 
	player_faculty(Faculty), 
	player_pos(X, Y), 
	player_sks(SKS),
	player_semester(Semester),
	player_intelligence(Intelligence),
	player_max_sks(Max_SKS),
	equipment(Equipment),
	player_inventory(Inventory),
	player_gold(Gold),
	player_progress(A,B,C,D),
	assignments(F,G,H,I),
	
	retract(player_sanity(Sanity)),
	retract(player_max_sanity(Max_Sanity)),
	retract(player_luck(Luck)),
	retract(player_faculty(Faculty)),
	retract(player_pos(X, Y)),
	retract(player_sks(SKS)),
	retract(player_semester(Semester)),
	retract(player_intelligence(Intelligence)),
	retract(player_max_sks(Max_SKS)),
	retract(equipment(Equipment)),
	retract(player_inventory(Inventory)),
	retract(player_gold(Gold)),
	retract(player_progress(A,B,C,D)),
	retract(assignments(F,G,H,I)),
	
	/* Read player data */
	read(Stream, New_Sanity),
	read(Stream, New_Max_Sanity),
	read(Stream, New_Luck),
	read(Stream, New_Faculty),
	read(Stream, New_X),
	read(Stream, New_Y),
	read(Stream, New_SKS),
	read(Stream, New_Semester),
	read(Stream, New_Intelligence),
	read(Stream, New_Max_SKS),
	read(Stream, New_Equipment),
	read(Stream, New_Inventory),
	read(Stream, New_Gold),
	read(Stream, New_A),
	read(Stream, New_B),
	read(Stream, New_C),
	read(Stream, New_D),
	read(Stream, New_F),
	read(Stream, New_G),
	read(Stream, New_H),
	read(Stream, New_I),
	
	asserta(player_sanity(New_Sanity)),
	asserta(player_max_sanity(New_Max_Sanity)),
	asserta(player_luck(New_Luck)),
	asserta(player_faculty(New_Faculty)),
	asserta(player_pos(New_X, New_Y)),
	asserta(player_sks(New_SKS)),
	asserta(player_semester(New_Semester)),
	asserta(player_intelligence(New_Intelligence)),
	asserta(player_max_sks(New_Max_SKS)),
	asserta(equipment(New_Equipment)),
	asserta(player_inventory(New_Inventory)),
	asserta(player_gold(New_Gold)),
	asserta(player_progress(New_A,New_B,New_C,New_D)),
	asserta(assignments(New_F,New_G,New_H,New_I)),
	
	map_items(Map_items),

	retract(map_items(Map_items)),
	
	/* Read map data */
	read(Stream, New_Map_items),		

	asserta(map_items(New_Map_items)),
	
	write('Successfully loaded!'), nl,
	close(Stream).

save(Filename):-
	/* Function to save file */
	
	open(Filename, write, Stream),

	/* Gathering data */
	player_sanity(Sanity), 
	player_max_sanity(Max_Sanity),
	player_luck(Luck), 
	player_faculty(Faculty), 
	player_pos(X, Y), 
	player_sks(SKS),
	player_semester(Semester),
	player_intelligence(Intelligence),
	player_max_sks(Max_SKS),
	equipment(Equipment),
	player_inventory(Inventory),
	player_gold(Gold),
	player_progress(A,B,C,D),
	assignments(F,G,H,I),
	
	map_items(Map_items),

	/* Write player data */
	write(Stream, Sanity), 			write(Stream, '.'), nl(Stream),
    write(Stream, Max_Sanity), 		write(Stream, '.'), nl(Stream),
	write(Stream, Luck), 			write(Stream, '.'), nl(Stream),
	write(Stream, Faculty), 		write(Stream, '.'), nl(Stream),
	write(Stream, X), 			    write(Stream, '.'), nl(Stream),
	write(Stream, Y), 		    	write(Stream, '.'), nl(Stream),
	write(Stream, Semester), 		write(Stream, '.'), nl(Stream),
	write(Stream, Intelligence),    write(Stream, '.'), nl(Stream),
	write(Stream, Max_SKS), 		write(Stream, '.'), nl(Stream),
	write(Stream, Equipment), 		write(Stream, '.'), nl(Stream),
	write(Stream, Inventory), 		write(Stream, '.'), nl(Stream),
	write(Stream, Gold), 		    write(Stream, '.'), nl(Stream),
	write(Stream, A), 		    	write(Stream, '.'), nl(Stream),
	write(Stream, B), 		    	write(Stream, '.'), nl(Stream),
	write(Stream, C), 		    	write(Stream, '.'), nl(Stream),
	write(Stream, D), 		    	write(Stream, '.'), nl(Stream),
	write(Stream, F), 		    	write(Stream, '.'), nl(Stream),
	write(Stream, G), 		    	write(Stream, '.'), nl(Stream),
	write(Stream, H), 		    	write(Stream, '.'), nl(Stream),
	write(Stream, I), 		    	write(Stream, '.'), nl(Stream),
	
	/* Write map data */
	write(Stream, Map_items), 		write(Stream, '.'), nl(Stream),
	
	write('Successfully saved!'), nl,
	close(Stream).