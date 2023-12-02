:- include('strings.pl').
:- use_module(library(dcg/basics)).

% tabla/3.
% Representa una tabla/sentencia de Álgebra relacional
tabla(X) --> literal(X).
tabla(X) --> operador(X).

alfabetico([]).
alfabetico([H|T]) :- is_alpha(H), alfabetico(T).

% literal/3. Si se usa como una DCG solo poner un parámetro.
% Representa una cadena alfanumérica, devuelve lit(string).
literal(lit(X)) --> string(Y),{alfabetico(Y),string_codes(X,Y)}.

literal2(lit(X)) --> string_a(Y),{string_codes(X,Y)}.

% operador/3.
% Representa a los posibles operadores de Álgebra Relacional.
operador(op(X)) --> proyeccion(X).
operador(op(X)) --> producto_cartesiano(X).
operador(op(X)) --> union(X).
operador(op(X)) --> diferencia(X).
%operador(op(X)) --> proyeccion(X) | producto_cartesiano(X) | union(X) | diferencia(X).

% proyeccion/3
% Representa al operador proyección.
proyeccion(proyec(X,Y)) --> "P(",literal(X),")(",tabla(Y),")".

% seleccion/3
% Representa al operador seleccion.
%seleccion(selecc(X,Y)) -->  ['S('],literal(X),[')('],tabla(Y),[')'].

% producto_cartesiano/3
% Representa al operador producto cartesiano.
producto_cartesiano(pc(X,Y)) --> "(",tabla(X),whites,"x",whites,tabla(Y),")".

% union/3
% Representa al operador unión.
union(u(X, Y)) --> "(",tabla(X),whites,"U",whites,tabla(Y),")".

% diferencia/3
% Representa al operador diferencia.
diferencia(dif(X,Y)) --> "(",tabla(X),whites,"-",whites,tabla(Y),")".