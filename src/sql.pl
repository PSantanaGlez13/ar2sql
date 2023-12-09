:- use_module(utiles).

select(Columna, [X|Y],Y) :- format(string(X), "SELECT ~w \n", [Columna]).
from(Tabla, [X|Y], Y) :- format(string(X), "FROM ~w", [Tabla]).

algebra_relacional_a_sql(lit(X), [Resultado|Hole]) :- select("*", Resultado, Parte2), from(X, Parte2, Parte3), punto_coma_final(Parte3, Hole).