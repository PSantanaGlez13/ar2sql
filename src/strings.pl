:- use_module(library(ctypes)).

string --> [X], string,{is_alpha(X)}.
string --> [].