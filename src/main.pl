:- include('algebra_relacional.pl').
:- use_module(library(pure_input)). % phrase_from_file/2

main :- phrase_from_file(literal(X), '../test/test_input.txt'), write(X).
