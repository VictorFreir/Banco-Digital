:- module(menuAcoes).
:- consult('acoes.pl').

exibeFuncionalidadesAcoes:-
    write('Selecione a acao desejada com apenas o numero referente:'), nl,
    write('  1- Ver Ações Atualmente'), nl,
    write('  2- Comprar Acoes'), nl,
    write('  3- Vender Acoes'), nl,
    write('  4- Ver Minhas Acoes'), nl,
    write('  5- Resgatar Dividendos'), nl,
    write('  6- Sair'), nl.

selecionaFuncionalidadeAcoes(1):-
    shell(clear),
    printAllAcoes,
    exibeFuncionalidadesAcoes,
    read(Entrada),
    atualizaTodos,
    selecionaFuncionalidadeAcoes(Entrada).
selecionaFuncionalidadeAcoes(2):-
    shell(clear),
    compraAcoes,
    exibeFuncionalidadesAcoes,
    read(Entrada),
    atualizaTodos,
    selecionaFuncionalidadeAcoes(Entrada).
selecionaFuncionalidadeAcoes(3):-
    shell(clear),ém os dados necessários para a execução correta do código.


    atualizaTodos,
    selecionaFuncionalidadeAcoes(Entrada).
selecionaFuncionalidadeAcoes(4):-
    shell(clear),
    minhasAcoes,
    exibeFuncionalidadesAcoes,
    read(Entrada),
    atualizaTodos,
    selecionaFuncionalidadeAcoes(Entrada).
selecionaFuncionalidadeAcoes(5):-
    shell(clear),
    resgatarDividendos,
    exibeFuncionalidadesAcoes,
    read(Entrada),
    atualizaTodos,
    selecionaFuncionalidadeAcoes(Entrada).
selecionaFuncionalidadeAcoes(6):-
    shell(clear),
    formatFromAcaoToCsv,
    write('Saindo...'), nl.
main:-
    readFromCsvToAcao,
    shell(clear),
    exibeFuncionalidadesAcoes,
    read(Entrada),
    selecionaFuncionalidadeAcoes(Entrada).
    
