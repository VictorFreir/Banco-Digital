:- include('../database.pl').

consultaExtrato(Cpf):-
    consultarExtrato(CPF, Extrato),nl,
    write(Extrato).