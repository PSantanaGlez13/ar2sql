:- include('algebra_relacional.pl').
:- include('sql.pl').
:- use_module(library(pure_input)). % phrase_from_file/2

main :- phrase_from_file(tabla(X), '../test/test_input.txt'),!, algebra_relacional_a_sql(X, [Resultado]), imprimir_resultado(Resultado).
