:- include('strings.pl').
:- use_module(library(dcg/basics)).

%tabla(X) --> operador(X) | literal(X).
literal(table(X)) --> string_a(Y),{string_codes(X,Y)}. % Representa
%operador(X) --> proyeccion(X) | seleccion(X) | pc(X) | union(X) | diferencia(X).