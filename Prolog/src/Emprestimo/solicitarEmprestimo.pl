:- dynamic conta/22.
:- include("../database.pl").


menuSolicitarEmprestimo(Cpf):-
    shell(clear),
    write("Bem vindo a area de emprestimos!"),nl,
    write("Para soliticar um emprestimo digite 1"),nl,
    write("Para voltar ao menu principal digite 0"),nl,
    read(Opcao),
    primeiroSeletorSolicita(Opcao,Cpf).

primeiroSeletorSolicita(1,Cpf):- 
    segundoSeletorSolicita(Cpf).

primeiroSeletorSolicita(_,_):-
    sair.

segundoSeletorSolicita(Cpf):-
    buscaSaldo(Cpf,Saldo),
    Saldo >= 500, !, menuSolicitar(Cpf),
    Saldo < 500, !, menuSemEmprestimo(Cpf).
    
menuSolicitar(Cpf):-
    shell(clear),
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
    terceiroSeletorSolicita(Opcao,Cpf,ValorParcela),
    solicitaEmprestimo(Cpf,ValorParcela),
    write("Emprestimo realizado com sucesso!"),nl.

terceiroSeletorSolicita(1,Cpf,ValorParcela):-
    true.

terceiroSeletorSolicita(_,Cpf,_):-
    naoSolicita(Cpf).

naoSolicita(Cpf):-
    write("O emprestimo nao foi realizado!"),nl,
    sair(Cpf).

menuSemEmprestimo(Cpf):-
    write("Infelizmente, nao temos nenhuma proposta de emprestimo para voce no momento..."),nl,
    sair(Cpf).

sair:- menuFuncionalidades(Cpf).

calculaValorEmprestimo(Cpf,ValorEmprestimo):-
    buscaSaldo(Cpf,Saldo),
    ValorEmprestimo is Saldo*2.
   
calculaValorTotalEmprestimo(ValorEmprestimo,ValorTotalEmprestimo):-
    ValorTotalEmprestimo is ValorEmprestimo*1.1.

calculaValorParcela(ValorTotalEmprestimo,ValorParcela):-
    ValorParcela is ValorTotalEmprestimo/10.

solicitaEmprestimo(Cpf,ValorParcela):-
    pegarDataAtual(Dia,Mes,Ano),
    alterarProximaParcela(Cpf,ValorParcela,Dia,Mes,Ano),
    alterarQtdParcelasRestantes(Cpf,10),
    write("Emprestimo soliticado com sucesso!"),
    sair(Cpf).

buscaSaldo(Cpf,Saldo):-
    consultarSaldo(Cpf,Saldo).
