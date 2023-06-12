:- consult('./Investimento/menuAcoes.pl').
:- consult('./Transferencia/transferencia.pl').
:- include('database.pl').
:- include('./Saque/saque.pl').
:- include('./Poupanca/poupanca.pl').

% :- include('consultarEmprestimo.pl').
% :- include('solicitarEmprestimo.pl').
% :- discontiguous buscaSaldo/2.
% :- discontiguous subtraiSaldo/3.
% :- discontiguous sair/0.
% :- discontiguous conta/3.
% :- discontiguous calculaValorTotalEmprestimo/2.

menuFuncionalidades(Cpf):-
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
    seletorFuncionalidades(Opcao,Cpf),
    menuFuncionalidades(Cpf).

seletorFuncionalidades(1,Cpf):-
    consultarSaldo(Cpf, Saldo),
    write("Seu saldo e : "), write(Saldo),nl.

seletorFuncionalidades(2,Cpf):-
    menuTransferencia(Cpf).

seletorFuncionalidades(3,Cpf):-
    sacar(Cpf).

seletorFuncionalidades(4,Cpf):-
    true.

seletorFuncionalidades(5,Cpf):-
    poupanca(Cpf).

seletorFuncionalidades(6,Cpf):-
    true.

seletorFuncionalidades(7,Cpf):-
    menuAcoes(Cpf).

seletorFuncionalidades(8,_):-
    write("=============== Fim da sessão ==============="),nl,
    menuPrincipal.

seletorFuncionalidades(_,_):-
    write("=============== Opção inválida ==============="),nl,
    menuFuncionalidades(Cpf).