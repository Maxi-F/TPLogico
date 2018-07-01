%-----BASE DE CONOCIMIENTO-----

%pareja(UnaPersona, OtraPersona)
pareja(marsellus, mia).
pareja(pumkin, honeyBunny).
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

%personaje(Nombre, Ocupacion)
personaje(pumkin, ladron([estacionesDeServicio, licorerias])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent, mafioso(maton)).
personaje(jules, mafioso(maton)).
personaje(marsellus, mafioso(capo)).
personaje(winston, mafioso(resuelveProblemas)).
personaje(mia, actriz([foxForceFive])).
personaje(butch, boxeador).
personaje(bernardo, mafioso(cerebro)).
personaje(bianca, actriz([elPadrino1])).
personaje(elVendedor, vender([humo, iphone])).
personaje(jimmie, vender([auto])).

%encargo(Solicitante, Encargado, Tarea).
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent, cuidar(mia)).
encargo(vincent, elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).
encargo(bernardo, vincent, buscar(jules, fuerteApache)).
encargo(bernardo, winston, buscar(jules, sanMartin)).
encargo(bernardo, winston, buscar(jules, lugano)).

%amigo(UnaPersona, OtraPersona)
amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

%----------PARTE 1----------

saleCon(Quien, Con):-
	pareja(Quien, Con).
saleCon(Quien, Con):-
	pareja(Con, Quien).

esFiel(Personaje):-
	saleCon(Personaje, _),
	findall(Pareja, saleCon(Pareja, Personaje), Parejas),
	length(Parejas, 1).

%CasoBase
acataOrden(Empleador, Empleado):-
	trabajaPara(Empleador, Empleado).
%CasoRecursivo
acataOrden(Empleador, Empleado):-
	trabajaPara(Superior, Empleado),
	acataOrden(Empleador, Superior).


%----------PARTE 2----------

esPeligroso(Personaje):-
	tieneJefePeligroso(Personaje).
esPeligroso(Personaje):-
	personaje(Personaje, mafioso(maton)).
esPeligroso(Personaje):-
	personaje(Personaje, ladron(LugaresRobados)),
	member(licorerias, LugaresRobados).
tieneJefePeligroso(Personaje):-
	trabajaPara(Jefe, Personaje),
	esPeligroso(Jefe).

tieneCerca(Persona, OtraPersona):-
	amigo(Persona, OtraPersona).
tieneCerca(Persona, OtraPersona):-
	amigo(OtraPersona, Persona).
tieneCerca(Persona, OtraPersona):-
	trabajaPara(Persona, OtraPersona).
tieneCerca(Persona, OtraPersona):-
	trabajaPara(OtraPersona, Persona).

sanCayetano(Persona):-
	tieneCerca(Persona, _),
	forall(tieneCerca(Persona, OtraPersona), encargo(Persona, OtraPersona, _)).

nivelRespeto(Personaje, Nivel):-
	personaje(Personaje, actriz(Peliculas)),
	length(Peliculas, Cantidad),
	Nivel is (Cantidad/10).
nivelRespeto(Personaje, 10):-
	personaje(Personaje, mafioso(resuelveProblemas)).
nivelRespeto(Personaje, 20):-
	personaje(Personaje, mafioso(capo)).
nivelRespeto(vincent, 15).

respetable(Personaje):-
	nivelRespeto(Personaje, Nivel),
	Nivel>9.

noRespetable(Personaje):-
	nivelRespeto(Personaje, Nivel),
	Nivel<9.
noRespetable(Personaje):-
	personaje(Personaje, ladron(_)).
noRespetable(Personaje):-
	personaje(Personaje, mafioso(maton)),
	Personaje \= vincent.
noRespetable(Personaje):-
	personaje(Personaje, boxeador).
noRespetable(Personaje):-
	personaje(Personaje, mafioso(cerebro)).
noRespetable(Personaje):-
	personaje(Personaje, vender(_)).
	
respetabilidad(Respetables, NoRespetables):-
	findall(Personaje, respetable(Personaje), ListaRespetables),
	length(ListaRespetables, Respetables),
	findall(Personaje, noRespetable(Personaje), ListaNoRespetables),
	length(ListaNoRespetables, NoRespetables).
	
cantidadEncargos(Personaje, CantidadEncargos):-
	personaje(Personaje, _),
	findall(Encargo, encargo(_, Personaje, Encargo), ListaEncargos),
	length(ListaEncargos, CantidadEncargos).
	
tieneMasCantidadDeEncargosQue(Personaje, OtroPersonaje):-
	cantidadEncargos(Personaje, UnaCantidadEncargos),
	cantidadEncargos(OtroPersonaje, OtraCantidadEncargos),
	UnaCantidadEncargos >= OtraCantidadEncargos.

masAtareado(Personaje):-
	personaje(Personaje, _),
	forall(personaje(OtroPersonaje, _), tieneMasCantidadDeEncargosQue(Personaje, OtroPersonaje)).
