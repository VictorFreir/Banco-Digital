:- discontiguous validar_idade/0.
:- discontiguous verificar_resposta/1.

validar_idade :-
    write('Você é maior de idade? (1 - Sim, 2 - Não): '),
    read(Resposta),
    (Resposta =:= 1 ->
        write('Você é maior de idade. Prosseguindo para o cadastro.')
    ;
        verificar_resposta(Resposta)
    ).

verificar_resposta(2) :-
    write('Você não é maior de idade. Não é possível cadastrar.'), nl,
    menu.
verificar_resposta(_) :-
    write('Resposta inválida. Por favor, escolha 1 para Sim ou 2 para Não.'),
    validar_idade.




