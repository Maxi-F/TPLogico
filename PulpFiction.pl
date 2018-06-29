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
	Pareja(Quien, Con).
saleCon(Quien, Con) :-
	Pareja(Con, Quien).
	

esFiel(Personaje) :-
	SaleCon(Personaje, _),
	findall(Pareja, SaleCon(Pareja, Personaje), Parejas),
	length(Parejas, 1).

%CasoBase	
acataOrden(Empleado, Empleador) :-
	trabajaPara(Empleador, Empleado).
%CasoRecursivo
acataOrden(Empleado, Empleador) :-
	trabajaPara(Superior, Empleado),
	acataOrden(Empleador, Superior).
