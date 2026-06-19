% ========================================
% TAREA BIRDS - MODULO 8
% Sistema Experto para Identificacion de Aves
% CAMBIO MOD 8: ask/2 y menuask/3 usan cut en lugar de not
% ========================================

% ========================================
% REGLAS DE IDENTIFICACION DE AVES (bird/1)
% ========================================

bird(paloma_comun) :-
    size(mediano),
    color(gris),
    habitat(urbano),
    noise(arrullar),
    flies(si).

bird(gorrion_comun) :-
    size(pequenio),
    color(cafe),
    habitat(urbano),
    noise(piar),
    flies(si).

bird(cardenal_nortenio) :-
    size(mediano),
    color(rojo),
    habitat(bosque),
    noise(silbar),
    flies(si).

bird(cuervo_comun) :-
    size(grande),
    color(negro),
    habitat(variado),
    noise(graznido),
    flies(si).

bird(colibri) :-
    size(muy_pequenio),
    color(verde),
    habitat(jardin),
    noise(zumbido),
    flies(si).

bird(aguila_real) :-
    size(muy_grande),
    color(cafe_oscuro),
    habitat(montana),
    noise(chirrido),
    flies(si).

bird(tucan_pico_canoa) :-
    size(grande),
    color(negro),
    habitat(selva),
    noise(croar),
    flies(si).

bird(perico_verde) :-
    size(mediano),
    color(verde),
    habitat(selva),
    noise(chillar),
    flies(si).

bird(buho_cornudo) :-
    size(grande),
    color(cafe),
    habitat(bosque),
    noise(ulular),
    flies(si).

bird(flamingo_rosa) :-
    size(muy_grande),
    color(rosa),
    habitat(costa),
    noise(trompetear),
    flies(si).

bird(pato_de_collar) :-
    size(mediano),
    color(verde),
    habitat(lago),
    noise(cuac),
    flies(si).

bird(lechuza_campanario) :-
    size(mediano),
    color(blanco),
    habitat(urbano),
    noise(chirrido),
    flies(si).

bird(pelicano_blanco) :-
    size(muy_grande),
    color(blanco),
    habitat(costa),
    noise(gruniido),
    flies(si).

bird(cenzontle) :-
    size(mediano),
    color(gris),
    habitat(urbano),
    noise(imitar),
    flies(si).

% ========================================
% PREDICADOS DE ATRIBUTOS
% ========================================
size(X)    :- known(size, X), !.
size(X)    :- ask(size, X).

color(X)   :- known(color, X), !.
color(X)   :- ask(color, X).

habitat(X) :- known(habitat, X), !.
habitat(X) :- ask(habitat, X).

noise(X)   :- known(noise, X), !.
noise(X)   :- ask(noise, X).

flies(X)   :- known(flies, X), !.
flies(X)   :- ask(flies, X).

% ========================================
% BASE DINAMICA
% ========================================
:- dynamic known/2.

% ========================================
% TAREA MOD 8: ask/2 con cut en lugar de not
% ========================================
% VERSION ANTERIOR (con not):
%   ask(Attr, Val) :-
%       ... read(Respuesta),
%       ( Respuesta = yes -> assert(known(Attr,Val)) ; fail ).
%
% VERSION MOD 8 (con cut):
%   Si el usuario responde yes  → guarda el hecho y tiene exito (!)
%   Si el usuario responde otra cosa → falla (no hay mas clausulas que probar)

ask(Attr, Val) :-
    write('El ave tiene ['), write(Attr),
    write('] = ['), write(Val), write('] ?'),
    nl,
    write('   Valores posibles para '), write(Attr), write(': '),
    opciones(Attr),
    write('   Responde (yes. / no.): '),
    read(Respuesta),
    nl,
    Respuesta = yes,    % falla directamente si no es yes (cut no necesario aqui)
    !,                  % CUT: si llego aqui, ya sabemos la respuesta es yes
    assert(known(Attr, Val)).
% Si Respuesta \= yes, el Respuesta = yes falla y ask/2 falla → backtracking normal

% ========================================
% TAREA MOD 8: menuask/3 con cut en lugar de not
% ========================================
% menuask/3 presenta un menu de opciones numeradas al usuario.
% VERSION CON CUT:
%   - Lee la opcion del usuario
%   - Si el valor elegido coincide con Val → guarda y exito (!)
%   - Si no coincide → falla sin seguir buscando alternativas

menuask(Attr, Val, Opciones) :-
    known(Attr, Val), !.        % ya sabemos la respuesta, cut para no preguntar
menuask(Attr, Val, Opciones) :-
    known(Attr, _), !,          % ya se pregunto este atributo pero con otro valor
    fail.
menuask(Attr, Val, Opciones) :-
    write('Selecciona ['), write(Attr), write(']:'), nl,
    mostrar_menu(Opciones, 1),
    write('Tu opcion (numero): '),
    read(NumOp),
    nl,
    nth1(NumOp, Opciones, ValElegido),  % obtiene el valor por numero
    assert(known(Attr, ValElegido)),    % guarda la eleccion
    !,                                  % CUT: ya elegiste, no hagas backtrack
    Val = ValElegido.                   % unifica con lo que la regla bird/1 espera

mostrar_menu([], _).
mostrar_menu([H|T], N) :-
    write('  '), write(N), write(') '), write(H), nl,
    N1 is N + 1,
    mostrar_menu(T, N1).

% ========================================
% opciones/1
% ========================================
opciones(size) :-
    write('muy_pequenio | pequenio | mediano | grande | muy_grande'), nl.
opciones(color) :-
    write('gris | cafe | rojo | negro | verde | blanco | rosa | cafe_oscuro'), nl.
opciones(habitat) :-
    write('urbano | bosque | selva | jardin | montana | lago | costa | variado'), nl.
opciones(noise) :-
    write('piar | arrullar | silbar | graznido | zumbido | chirrido |'), nl,
    write('   croar | chillar | ulular | trompetear | cuac | gruniido | imitar'), nl.
opciones(flies) :-
    write('si | no'), nl.

% ========================================
% identificar/1
% ========================================
reset_conocidos :- retractall(known(_, _)).

identificar(Ave) :-
    reset_conocidos,
    nl,
    write('=== SISTEMA EXPERTO - IDENTIFICACION DE AVES ==='), nl,
    write('Responde con yes. o no. (con punto al final)'), nl,
    write('================================================'), nl, nl,
    bird(Ave), !,
    nl,
    write('>>> Ave identificada: '), write(Ave), nl,
    write('================================================'), nl.
identificar(_) :-
    nl,
    write('>>> No se pudo identificar el ave.'), nl,
    write('    El ave puede no estar en la base de datos.'), nl.