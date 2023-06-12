:- include('menuLogin.pl').



recuperaSenha:-
    write('Informe seu CPF: '),
    read(CPF),
    ( consultarCPF(CPF)
    ->
    conta(_, _, _, CPF, _, _, _, PerguntaSecreta, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    write('A sua pergunta secreta é: '), write(PerguntaSecreta), nl,
    write('Para alterar sua senha, responda a pergunta secreta (entre aspas): '),
    read(Resposta),
    (
        (   consultarPerguntaSecreta(CPF, PerguntaSecreta, Resposta))
        ->  write('Resposta correta!'), nl,
            write('Informe sua nova senha (entre aspas): '),
            read(NovaSenha),
            alterarSenha(CPF, NovaSenha), nl,
            write('Senha alterada com sucesso'), nl,
            write('                           '),
            write('Voltando ao menu principal.'),nl,
            menu
        ;   write('Respostas não conferem'), nl,
            write('                            '),
            write('Voltando ao menu principal.'),
            nl,
            menu
        )
    	;   write('Cpf não consta na base de dados.'), nl,
            write('Voltando ano menu principal.'), nl,
            menu

    ).

