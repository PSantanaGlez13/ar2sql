:- use_module(library(ctypes)).

string_a([]) --> [].
string_a([X|Y]) --> [X], string_a(Y),{is_alpha(X)}.