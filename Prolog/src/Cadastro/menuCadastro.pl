:- discontiguous menuCadastro/0.

:- include('menuLogin.pl').
:- include('validaData.pl').
:- include('../database.pl').


% Predicado principal para testar o cadastro de clientes
menuCadastro :-
    write('--- Cadastro de Clientes ---'), nl,
    write('Informe seu nome (entre aspas): '),nl,
    read(Nome),nl,
    validar_idade, nl,
    write('Informe sua Data de Nascimento no formato dd/mm/aaaa (entre aspas): '),nl,
    read(DataNascimento),nl,
    write('Informe seu endereço (entre aspas): '), nl,
    read(Endereco), nl,
    write('CPF: '),nl,
    read(CPF),nl,
    write('Crie uma pergunta secreta para sua conta (entre aspas): '),nl,
    read(PerguntaSecreta),
    write('Crie uma resposta secreta para sua pergunta (entre aspas): '),nl,
    read(RespostaSecreta),nl,
    write('Crie uma senha para sua conta (entre aspas): '),nl,
    read(Senha),nl,
    Extrato = 'EXTRATO: ',
    criaConta(Nome, _, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, _, _, _, _, _, _, _, _,_,_, _, _, Extrato) , incrementa_id,
    write('Cliente cadastrado com sucesso.'), nl,
    menuPrincipal.

