:- include('./database.pl').
:- include('./Cadastro/menuPrincipal.pl').

main:-
    lerContas,
    menuPrincipal.