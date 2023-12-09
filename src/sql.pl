:- use_module(utiles).

select(Columna, [X|Y],Y) :- format(string(X), "SELECT ~w \n", [Columna]).
from(lit(Tabla), [X|Y], Y) :- format(string(X), "FROM ~w", [Tabla]).
from(op(Tabla), [X|Y], Y) :- algebra_relacional_a_sql(op(Tabla), Result, []), combinar_strings(Result,"",StringFinal),format(string(X), "FROM (~w)", [StringFinal]).
from(pc(lit(A),lit(B)), [X|Y], Y) :- format(string(X), "FROM ~w,~w", [A,B]).
from(pc(lit(A),op(B)), [X|Y], Y) :- algebra_relacional_a_sql(op(B), Result, []), combinar_strings(Result,"",StringFinal),format(string(X), "FROM ~w,(~w)", [A, StringFinal]).
from(pc(op(A),lit(B)), [X|Y], Y) :- algebra_relacional_a_sql(op(A), Result, []), combinar_strings(Result,"",StringFinal),format(string(X), "FROM (~w),~w", [StringFinal, B]).
from(pc(op(A),op(B)), [X|Y], Y) :- algebra_relacional_a_sql(op(A), Result, []), combinar_strings(Result,"",StringFinal),
                                   algebra_relacional_a_sql(op(B), Result2, []), combinar_strings(Result2,"",StringFinal2),
                                   format(string(X), "FROM (~w),(~w)", [StringFinal, StringFinal2]).

where(Condicion, [X|Y], Y) :- expresion_logica_a_string(Condicion,[Result],[]), format(string(X), "WHERE ~w", [Result]).


algebra_relacional_a_sql(lit(X), Resultado, Hole) :- select("*", Resultado, Parte2), from(lit(X), Parte2, Hole).

algebra_relacional_a_sql(op(selecc(X,Y)), Resultado, Hole) :- select("*", Resultado, Parte2),
                                                              from(Y,Parte2, Parte3), nueva_linea(Parte3, Parte4), where(X,Parte4,Hole).

algebra_relacional_a_sql(op(proyec(lit(X),Y)), Resultado, Hole) :- select(X, Resultado, Parte2),
                                                                    from(Y, Parte2, Hole).

algebra_relacional_a_sql(op(pc(X,Y)),Resultado, Hole) :- select("*", Resultado, Parte2),
                                                          from(pc(X,Y), Parte2, Hole).
 
algebra_relacional_a_sql(op(u(X,Y)), Resultado, Hole) :- algebra_relacional_a_sql(X, Resultado, Parte2),
                                                         poner_union(Parte2, Parte3),
                                                         algebra_relacional_a_sql(Y, Parte3, Hole).

algebra_relacional_a_sql(op(dif(X,Y)), Resultado, Hole) :- algebra_relacional_a_sql(X, Resultado, Parte2),
                                                         poner_minus(Parte2, Parte3),
                                                         algebra_relacional_a_sql(Y, Parte3, Hole).

/*
algebra_relacional_a_sql(op(selecc(X,lit(Y)),[Resultado|Hole])) :- select("*", Resultado, Parte2),%algebra_relacional_a_sql(Y, [Parte2|Parte3]),
                                                               from(Y,Parte2, Parte3), nueva_linea(Parte3, Parte4), where(X,Parte4,Parte5),
                                                               punto_coma_final(Parte5,Hole).
                                                              */