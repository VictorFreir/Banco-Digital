:- include('menuCadastro.pl').
:- include('menuRecuperaSenha.pl').
:- include('menuLogin.pl').
:- include('validaData.pl').

    
menuPrincipal :-
    nl,
    repeat,
    write('--- Menu ---'), nl,
    write('1. Cadastro de Cliente'), nl,
    write('2. Redefinição de Senha'), nl,
    write('3. Login'), nl,
    write('4. Sair'), nl,
    write('Escolha uma opção: '),
    read(Opcao),
    executar_opcao(Opcao).

executar_opcao(1) :-
    menuCadastro,
    nl.

executar_opcao(2) :-
    recuperaSenha,
    nl.

executar_opcao(3) :-
    login,
    nl.

executar_opcao(4):-
    registrarDadosNoCSV,
    write("=============== Obrigado por usar nossos serviços ==============="),
    halt.

executar_opcao(_) :-
    write('Opção inválida. Tente novamente.'), nl,
    menuPrincipal.


