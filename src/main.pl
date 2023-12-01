:- include('strings.pl').
:- use_module(library(pure_input)). % phrase_from_file/2

main :- phrase_from_file(string, '../test/test_input.txt').
