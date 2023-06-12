:- consult('Investimento/menuAcoes.pl').
%:- consult('Transferencia/transferencia.pl').
:- include('database.pl').
% :- include('consultarEmprestimo.pl').
% :- include('solicitarEmprestimo.pl').
% :- discontiguous buscaSaldo/2.
% :- discontiguous subtraiSaldo/3.
% :- discontiguous sair/0.
% :- discontiguous conta/3.
% :- discontiguous calculaValorTotalEmprestimo/2.

menuFuncionalidades:-
    lerContas,
    write("=============== menu principal ==============="),nl,
    write("Digite a operacao desejada apenas com o numero:"),nl,
    write("1- Consultar Saldo"),nl,
    write("2- Transferir"),nl,
    write("3- Sacar"),nl,
    write("4- Consultar extrato"),nl,
    write("5- Poupanca"),nl,
    write("6- Emprestimos"),nl,
    write("7- Acoes"),nl,
    write("8- Sair"),nl,
    read(Opcao),
    Cpf is 15241593446,
    seletorFuncionalidades(Opcao,Cpf),
    menuFuncionalidades.

seletorFuncionalidades(1,Cpf):-
    true.

seletorFuncionalidades(2,Cpf):-
    menuTransferencia(Cpf).

seletorFuncionalidades(3,Cpf):-
    true.

seletorFuncionalidades(4,Cpf):-
    true.

seletorFuncionalidades(5,Cpf):-
    true.

seletorFuncionalidades(6,Cpf):-
    true.

seletorFuncionalidades(7,Cpf):-
    menuAcoes(Cpf).

seletorFuncionalidades(_,_):-
    write("=============== Fim da execucao ==============="),
    halt.
