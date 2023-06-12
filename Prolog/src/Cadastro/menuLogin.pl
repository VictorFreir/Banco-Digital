:- discontiguous validar_login/2.
:- discontiguous login/0.

:- include('../menuFuncionalidades.pl').

login:-
    write('--- Login ---'), nl,
    write('Para efetuar login informe seu CPF:'), nl,
    read(Cpf), nl,
    write('Agora informe sua senha(entre aspas): '), nl,
    read(Senha), nl,
    (
        consultarSenha(Cpf, Senha) ->
        write('Login realizado com sucesso.'), nl,
        menuFuncionalidades(Cpf)
    ;
        write('CPF ou senha inválidos, tente novamente.'), nl,
        menuPrincipal
    ).




