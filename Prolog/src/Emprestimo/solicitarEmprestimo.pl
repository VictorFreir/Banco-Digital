:- dynamic conta/3.

conta("victor",15241593446, 1000).
menuSolicitarEmprestimo:-
    write("Bem vindo a area de emprestimos!"),nl,
    write("Para soliticar um emprestimo digite 1"),nl,
    write("Para voltar ao menu principal digite 0"),nl,
    read(Opcao),
    Cpf is 15241593446,
    primeiroSeletorSolicita(Opcao,Cpf).

primeiroSeletorSolicita(1,Cpf):- 
    segundoSeletorSolicita(Cpf).

primeiroSeletorSolicita(_,_):-
    sair.

segundoSeletorSolicita(Cpf):-
    buscaSaldo(Cpf,Saldo),
    Saldo >= 500, !, menuSolicitar(Cpf),
    Saldo < 500, !, menuSemEmprestimo.
    
menuSolicitar(Cpf):-
    write("Voce tem uma proposta de emprestimo!"),nl,
    calculaValorEmprestimo(Cpf, ValorEmprestimo),
    calculaValorTotalEmprestimo(ValorEmprestimo,ValorTotalEmprestimo),
    calculaValorParcela(ValorEmprestimo,ValorParcela),
    write("Valor total: "), write(ValorEmprestimo), nl,
    write("Valor das parcelas: "), write(ValorParcela),nl,
    write("Valor total a pagar: "), write(ValorTotalEmprestimo),nl,
    write("Voce deseja realizar o emprestimo?"),nl,
    write("Digite 1, para sim"),nl,
    write("Digite 0, para nao"),nl,
    read(Opcao),
    terceiroSeletorSolicita(Opcao),
    soliticaEmprestimo(Cpf,ValorEmprestimo,ValorTotalEmprestimo,ValorParcela),
    write("Emprestimo realizado com sucesso!"),nl.

terceiroSeletorSolicita(1):-
    true.

terceiroSeletorSolicita(_):-
    naoSolicita.

naoSolicita:-
    write("O emprestimo nao foi realizado!"),
    sair.

menuSemEmprestimo:-
    write("Infelizmente, nao temos nenhuma proposta de emprestimo para voce no momento...") .

sair:- abort.

calculaValorEmprestimo(Cpf,ValorEmprestimo):-
    buscaSaldo(Cpf,Saldo),
    ValorEmprestimo is Saldo*2.
   
calculaValorTotalEmprestimo(ValorEmprestimo,ValorTotalEmprestimo):-
    ValorTotalEmprestimo is ValorEmprestimo*1.1.

calculaValorParcela(ValorTotalEmprestimo,ValorParcela):-
    ValorParcela is ValorTotalEmprestimo/10.

soliticaEmprestimo(Cpf,ValorEmprestimo,ValorTotalEmprestimo,ValorParcela):-
    true.
    % implementar metodo de raniel

buscaSaldo(Cpf,Saldo):-
    conta(_,Cpf,Saldo).
