%pareja(Persona, Persona)
pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).
pareja(bernardo, bianca).
pareja(bernardo, charo).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).
trabajaPara(vincent, bernardo).
trabajaPara(winston, bernardo).
trabajaPara(bianca, george).
trabajaPara(charo, george).

saleCon(Quien, Con) :-
	pareja(Quien, Con).
saleCon(Quien, Con) :-
	pareja(Con, Quien).
	

esFiel(Personaje) :-
	saleCon(Personaje, _),
	findall(Pareja, saleCon(Pareja, Personaje), Parejas),
	length(Parejas, 1).

%CasoBase	
acataOrden(Empleado, Empleador) :-
	trabajaPara(Empleador, Empleado).
%CasoRecursivo
acataOrden(Empleado, Empleador) :-
	trabajaPara(Superior, Empleado),
	acataOrden(Empleador, Superior).
