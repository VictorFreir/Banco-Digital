:- consult('./Investimento/menuAcoes.pl').
:- consult('./Transferencia/transferencia.pl').
:- include('database.pl').
:- include('./Saque/saque.pl').
:- include('./Poupanca/poupanca.pl').
:- include('./Cadastro/menuExtrato.pl').
:- consult('./Emprestimo/consultarEmprestimo.pl').
:- consult('./Emprestimo/solicitarEmprestimo.pl').

% :- discontiguous buscaSaldo/2.
% :- discontiguous subtraiSaldo/3.
% :- discontiguous sair/0.
% :- discontiguous conta/3.
% :- discontiguous calculaValorTotalEmprestimo/2.

menuFuncionalidades(Cpf):-
    shell(clear),
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
    shell(clear),
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
    consultaExtrato(Cpf).

seletorFuncionalidades(5,Cpf):-
    poupanca(Cpf).

seletorFuncionalidades(6,Cpf):-
    consultarQtdParcelasRestantes(Cpf, ParcelasRestantes),
    ParcelasRestantes > 0, 
    !,
    menuConsultarEmprestimo(Cpf).

seletorFuncionalidades(6,Cpf):-
    menuSolicitarEmprestimo(Cpf).

seletorFuncionalidades(7,Cpf):-
    menuAcoes(Cpf).

seletorFuncionalidades(8,_):-
    shell(clear),
    write("=============== Fim da sessao ==============="),nl,
    menuPrincipal.

seletorFuncionalidades(_,_):-
    shell(clear),
    write("=============== Opcao invalida ==============="),nl,
    menuFuncionalidades(Cpf).