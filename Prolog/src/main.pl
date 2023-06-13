:- include('./database.pl').
:- include('./Cadastro/menuPrincipal.pl').
:- include('./Investimento/acoes.pl').

main:-
    lerContas,
    readFromCsvToAcao,
    menuPrincipal.