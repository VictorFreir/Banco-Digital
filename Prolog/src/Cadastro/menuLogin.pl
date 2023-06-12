:- discontiguous validar_login/iscontiguous validar_login/2.
:- discontiguous login/0.

%:- include('menuFuncinalidades.pl').

login:-
    write('--- Login ---'), nl,
    write('Para efetuar login informe seu CPF:'), nl,
    read(Cpf), nl,
    write('Agora informe sua senha(entre aspas): '), nl,
    read(Senha), nl,
    (
        consultarSenha(Cpf, Senha) ->
        write('Login realizado com sucesso.'), nl
        %menuFuncinalidades
    ;
        write('CPF ou senha inválidos, tente novamente.'), nl,
        menuPrincipal
    ).




