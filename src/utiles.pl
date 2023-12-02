:- use_module(library(ctypes)).
:- use_module(library(dcg/basics)).

string_a([]) --> [].
string_a([X|Y]) --> [X], string_a(Y),{is_alpha(X)}.


alfabetico([]).
alfabetico([H|T]) :- is_alpha(H), alfabetico(T).

% literal/3. Si se usa como una DCG solo poner un parámetro.
% Representa una cadena alfanumérica, devuelve lit(string).
literal(lit(X)) --> string(Y),{alfabetico(Y),string_codes(X,Y)}.

expresion_logica(X) --> mayor(X) | mayor_igual(X) | menor(X) | menor_igual(X) | igual(X) | conjuncion(X) | disyuncion(X).

termino_comparacion(int(X)) --> integer(X).
termino_comparacion(X) --> literal(X).

mayor(mayor(X,Y)) --> termino_comparacion(X), whites,">",whites,termino_comparacion(Y).
mayor_igual(mayor_igual(X,Y)) --> termino_comparacion(X), whites,">=",whites,termino_comparacion(Y).
menor(menor(X,Y)) --> termino_comparacion(X), whites,"<",whites,termino_comparacion(Y).
menor_igual(menor_igual(X,Y)) --> termino_comparacion(X), whites,"<=",whites,termino_comparacion(Y).
igual(igual(X,Y)) --> termino_comparacion(X), whites,"=",whites,termino_comparacion(Y).
conjuncion(conjuncion(X,Y)) --> "(",expresion_logica(X), whites,"Y",whites,expresion_logica(Y),")".
disyuncion(disyuncion(X,Y)) --> "(",expresion_logica(X), whites,"O",whites,expresion_logica(Y),")".
