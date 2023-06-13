:- consult('acoes.pl').

exibeFuncionalidadesAcoes:-
    write('Selecione a acao desejada com apenas o numero referente:'), nl,
    write('  1- Ver Ações Atualmente'), nl,
    write('  2- Comprar Acoes'), nl,
    write('  3- Vender Acoes'), nl,
    write('  4- Ver Minhas Acoes'), nl,
    write('  5- Resgatar Dividendos'), nl,
    write('  6- Sair'), nl.

selecionaFuncionalidadeAcoes(1, Cpf):-
    shell(clear),
    printAllAcoes,
    exibeFuncionalidadesAcoes,
    read(Entrada),
    atualizaTodos,
    selecionaFuncionalidadeAcoes(Entrada, Cpf).
selecionaFuncionalidadeAcoes(2, Cpf):-
    shell(clear),
    compraAcoes(Cpf),
    exibeFuncionalidadesAcoes,
    read(Entrada),
    atualizaTodos,
    selecionaFuncionalidadeAcoes(Entrada, Cpf).
selecionaFuncionalidadeAcoes(3, Cpf):-
    shell(clear),
    vendeAcoes(Cpf),
    exibeFuncionalidadesAcoes,
    read(Entrada),
    atualizaTodos,
    selecionaFuncionalidadeAcoes(Entrada, Cpf).
selecionaFuncionalidadeAcoes(4, Cpf):-
    shell(clear),
    minhasAcoes(Cpf),
    exibeFuncionalidadesAcoes,
    read(Entrada),
    atualizaTodos,
    selecionaFuncionalidadeAcoes(Entrada, Cpf).
selecionaFuncionalidadeAcoes(5, Cpf):-
    shell(clear),
    resgatarDividendos(Cpf),
    exibeFuncionalidadesAcoes,
    read(Entrada),
    atualizaTodos,
    selecionaFuncionalidadeAcoes(Entrada, Cpf).
selecionaFuncionalidadeAcoes(6, Cpf):-
    shell(clear),
    formatFromAcaoToCsv,
    write('Saindo...'), nl.
selecionaFuncionalidadeAcoes(_, Cpf):-
    shell(clear),
    write('Acao Invalida, por favor, selecione novamente!'),
    exibeFuncionalidadesAcoes,
    read(Entrada),
    selecionaFuncionalidadeAcoes(Entrada, Cpf).

menuAcoes(Cpf):-
    readFromCsvToAcao,
    shell(clear),
    exibeFuncionalidadesAcoes,
    read(Entrada),
    selecionaFuncionalidadeAcoes(Entrada, Cpf).
    
