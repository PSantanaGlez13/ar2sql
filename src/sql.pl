:- use_module(utiles).

select(Columna, [X|Y],Y) :- format(string(X), "SELECT ~w \n", [Columna]).
from(Tabla, [X|Y], Y) :- format(string(X), "FROM ~w", [Tabla]).
where(Condicion, [X|Y], Y) :- expresion_logica_a_string(Condicion,[Res],[]), format(string(X), "WHERE ~w", [Res]).

algebra_relacional_a_sql(op(selecc(X,lit(Y))),[Resultado|Hole]) :- select("*", Resultado, Parte2), %algebra_relacional_a_sql(Y, [Parte2|Parte3]),
                                                               from(Y,Parte2, Parte3), nueva_linea(Parte3, Parte4), where(X,Parte4,Parte5),
                                                               punto_coma_final(Parte5,Hole).


algebra_relacional_a_sql(lit(X), [Resultado|Hole]) :- select("*", Resultado, Parte2), from(X, Parte2, Parte3), punto_coma_final(Parte3, Hole).

/*
algebra_relacional_a_sql(op(selecc(X,lit(Y)),[Resultado|Hole])) :- select("*", Resultado, Parte2),%algebra_relacional_a_sql(Y, [Parte2|Parte3]),
                                                               from(Y,Parte2, Parte3), nueva_linea(Parte3, Parte4), where(X,Parte4,Parte5),
                                                               punto_coma_final(Parte5,Hole).
                                                              */