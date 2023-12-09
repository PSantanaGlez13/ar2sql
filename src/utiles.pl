:- module(utiles,[imprimir_resultado/1,nueva_linea/2,punto_coma_final/2,literal/3,expresion_logica/3,expresion_logica_a_string/3,combinar_strings/3,
                  poner_minus/2, poner_union/2]).
:- use_module(library(ctypes)).
:- use_module(library(dcg/basics)).

%string_a([]) --> [].
%string_a([X|Y]) --> [X], string_a(Y),{is_alpha(X)}.

imprimir_resultado([]).
imprimir_resultado([Resultado|Resto]) :- write(Resultado), imprimir_resultado(Resto).

nueva_linea(["\n"|Hole], Hole).
punto_coma_final([";"|Hole], Hole).

alfabetico([]).
alfabetico([H|T]) :- is_alpha(H), alfabetico(T).

% literal/3. Si se usa como una DCG solo poner un parámetro.
% Representa una cadena alfanumérica, devuelve lit(string).
literal(lit(X)) --> string(Y),{alfabetico(Y),string_codes(X,Y)}.
%literal(lit(X)) --> string_without([" ", ">", "<", "<=", ">=", "!=", "=", "Y", "O", "U", "x", "U", "-", "(", ")"],
%                                   Codes), {alfabetico(Codes),string_codes(X,Codes), write(Codes)}.

expresion_logica(X) --> mayor(X) | mayor_igual(X) | menor(X) | menor_igual(X) | igual(X) |
                        conjuncion(X) | disyuncion(X) | no_igual(X).

termino_comparacion(lit(X)) --> integer(Y),{number_string(Y,X)}.
termino_comparacion(X) --> literal(X).

mayor(mayor(X,Y)) --> termino_comparacion(X), whites,">",whites,termino_comparacion(Y).
mayor_igual(mayor_igual(X,Y)) --> termino_comparacion(X), whites,">=",whites,termino_comparacion(Y).
menor(menor(X,Y)) --> termino_comparacion(X), whites,"<",whites,termino_comparacion(Y).
menor_igual(menor_igual(X,Y)) --> termino_comparacion(X), whites,"<=",whites,termino_comparacion(Y).
igual(igual(X,Y)) --> termino_comparacion(X), whites,"=",whites,termino_comparacion(Y).
no_igual(no_igual(X,Y)) --> termino_comparacion(X), whites,"!=",whites,termino_comparacion(Y).
conjuncion(conjuncion(X,Y)) --> "(",expresion_logica(X), whites,"Y",whites,expresion_logica(Y),")".
disyuncion(disyuncion(X,Y)) --> "(",expresion_logica(X), whites,"O",whites,expresion_logica(Y),")".


poner_and([" AND "|H], H).
poner_or([" OR "|H], H).
poner_union(["\nUNION\n"|H], H).
poner_minus(["\nMINUS\n"|H], H).
abrir_parentesis(["("|H], H).
cerrar_parentesis([")"|H], H).

combinar_strings([], Resultado, Resultado).
combinar_strings([Head|Tail], StringActual, Resultado) :- string_concat(StringActual, Head, StringNueva),
                                                          combinar_strings(Tail, StringNueva, Resultado).

expresion_logica_a_string(mayor(lit(A),lit(B)), [X|Y], Y) :- format(string(X),"~w > ~w", [A,B]).
expresion_logica_a_string(mayor_igual(lit(A),lit(B)), [X|Y], Y) :- format(string(X),"~w >= ~w", [A,B]).
expresion_logica_a_string(menor(lit(A),lit(B)), [X|Y], Y) :- format(string(X),"~w < ~w", [A,B]).
expresion_logica_a_string(menor_igual(lit(A),lit(B)), [X|Y], Y) :- format(string(X),"~w <= ~w", [A,B]).
expresion_logica_a_string(igual(lit(A),lit(B)), [X|Y], Y) :- format(string(X),"~w = ~w", [A,B]).
expresion_logica_a_string(no_igual(lit(A),lit(B)), [X|Y], Y) :- format(string(X),"~w != ~w", [A,B]).
expresion_logica_a_string(conjuncion(A,B), [Resultado|H], H) :- expresion_logica_a_string(A,ListaStrings, H1), poner_and(H1,H2),
                                                             expresion_logica_a_string(B, H2, []), combinar_strings(ListaStrings, "", Resultado).
expresion_logica_a_string(disyuncion(A,B), [Resultado|H], H) :- expresion_logica_a_string(A,ListaStrings, H1), poner_or(H1,H2),
                                                             expresion_logica_a_string(B, H2, []), combinar_strings(ListaStrings, "", Resultado).