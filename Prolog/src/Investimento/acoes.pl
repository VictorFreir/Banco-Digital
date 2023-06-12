:- module(acoes).
:- dynamic acao/4.
:- use_module(library(csv)).
:- consult('../database.pl').

atualizaPrecoNaRegra(IdAcao, Preco):-
    retract(acao(IdAcao,Nome, _,Div)),
    assert(acao(IdAcao,Nome, Preco, Div)).

calculaRendimento(ValorAtual, ValorNovo):-
    random(0, 3, Numero),
    (Numero =:= 0 -> Valor is ValorAtual * 0.90 ; Valor is ValorAtual * 1.10),
    ValorNovo is round(Valor * 100) / 100.

atualizaTodos:-
    acao(1,pixget,PrecoPG,0.01),
    acao(2,haiscompany,PrecoHC,0.03),
    acao(3,muquiff,PrecoMQ,0.08),
    calculaRendimento(PrecoPG, NPG),
    calculaRendimento(PrecoHC, PHC),
    calculaRendimento(PrecoMQ, PMQ),
    atualizaPrecoNaRegra(1, NPG),
    atualizaPrecoNaRegra(2, PHC),
    atualizaPrecoNaRegra(3, PMQ).

printAllAcoes:-
    acao(1,pixget,PrecoPG,0.01),
    acao(2,haiscompany,PrecoHC,0.03),
    acao(3,muquiff,PrecoMQ,0.08),
    write('1 - PixGet - Valor: R$ '), write(PrecoPG), write(' - Dividendos: 1%'), nl,
    write('2 - HaisCompany - Valor: R$ '), write(PrecoHC), write(' - Dividendos: 3%'), nl,
    write('3 - Muquiff - Valor: R$ '), write(PrecoMQ), write(' - Dividendos: 8%'), nl.

compraAcoes(Cpf):-
    write('Digite o ID da acao que deseja comprar:'), nl,
    printAllAcoes,
    read(IdAcao),
    write('Digite a quantidade de acoes que deseja comprar:'), nl,
    read(Quantidade),
    acao(IdAcao, _, Preco, _),
    ValorNovo is Preco * Quantidade,
    Valor is round(ValorNovo * 100) / 100,
    write('Valor total da compra: R$ '), write(Valor), nl,
    consultarSaldo(Cpf, Saldo),
    write('Atualmente, seu saldo é: R$ '), write(Saldo), nl,
    write('Digite 1 para confirmar ou 0 para cancelar:'), nl,
    read(Confirmacao),
    pegaAcao1(Cpf, A1),
    Na1 is A1 + Quantidade,
    pegaAcao2(Cpf, A2),
    Na2 is A2 + Quantidade,
    pegaAcao3(Cpf, A3),
    Na3 is A3 + Quantidade,
    NSaldo is Saldo - Valor,
    (Confirmacao =:= 1 ->
        (IdAcao =:= 1 -> 
            alterarAcao1(Cpf, Na1) ; (IdAcao =:= 2 -> alterarAcao2(Cpf, Na2) ; alterarAcao3(Cpf, Na3))); false
    ),
    (Confirmacao =:= 1 -> 
        write('Compra realizada com sucesso!'), alterarSaldo(Cpf, NSaldo); write('Compra cancelada!')),nl.

vendeAcoes(Cpf):- 
    minhasAcoes(Cpf),
    write('Digite o ID da acao que deseja vender:'), nl,
    read(IdAcao),
    write('Digite a quantidade de acoes que deseja vender:'), nl,
    read(Quantidade),
    acao(IdAcao, _, Preco, _), 
    ValorNovo is Preco * Quantidade,
    Valor is round(ValorNovo * 100) / 100,
    write('Valor total da venda: R$ '), write(Valor), nl,
    write('Digite 1 para confirmar ou 0 para cancelar:'), nl,
    read(Confirmacao),
    pegaAcao1(Cpf, A1),
    Na1 is A1 - Quantidade,
    pegaAcao2(Cpf, A2),
    Na2 is A2 - Quantidade,
    pegaAcao3(Cpf, A3),
    Na3 is A3 - Quantidade,
    consultarSaldo(Cpf, Saldo),
    NSaldo is Saldo + Valor,
    (Confirmacao =:= 1 ->
        (IdAcao =:= 1 -> 
            alterarAcao1(Cpf, Na1) ; (IdAcao =:= 2 -> alterarAcao2(Cpf, Na2) ; alterarAcao3(Cpf, Na3))); false
    ),
    (Confirmacao =:= 1 -> 
        alterarSaldo(Cpf, NSaldo),
        write('Venda realizada com sucesso!'),nl,
        write('Voce recebeu R$ '), write(Valor), write(' em sua conta!')
        ; write('Venda cancelada!')),nl.

minhasAcoes(Cpf):-
    pegaAcao1(Cpf, A1),
    pegaAcao2(Cpf, A2),
    pegaAcao3(Cpf, A3), 
    write('Atualmente, voce possui as seguintes acoes:'), nl,
    write('1 - PixGet - Quantidade: '), write(A1), nl,
    write('2 - HaisCompany - Quantidade: '), write(A2), nl,
    write('3 - Muquiff - Quantidade: '), write(A3), nl.

resgatarDividendos(Cpf):-
    acao(1,pixget,PrecoPG,0.01),
    acao(2,haiscompany,PrecoHC,0.03),
    acao(3,muquiff,PrecoMQ,0.08),
    pegaAcao1(Cpf, A1),
    pegaAcao2(Cpf, A2),
    pegaAcao3(Cpf, A3),
    D1 is PrecoPG * 0.01,
    D2 is PrecoHC * 0.03,
    D3 is PrecoMQ * 0.08,
    V1 is D1 * A1,
    V2 is D2 * A2,
    V3 is D3 * A3,
    ValorNovo is V1 + V2 + V3,
    Valor is round(ValorNovo * 100) / 100,
    consultarSaldo(Cpf, Saldo),
    NSaldo is Saldo + Valor,
    write('Valor total dos dividendos para ser recuperados: R$ '), write(Valor), nl,
    write('Digite 1 para confirmar ou 0 para cancelar:'), nl,
    read(Confirmacao),
    (Confirmacao =:= 1 -> 
        alterarSaldo(Cpf, NSaldo),
        write('Dividendos resgatados com sucesso!'), nl,
        write('Voce recebeu R$ '), write(Valor), write(' em sua conta!'), nl
        ; write('Resgate cancelado!'), nl).


readFromCsvToAcao:-
    csv_read_file('Prolog/src/Investimento/acoes.csv', Rows, [functor(acao), arity(4)]),
    maplist(assert, Rows).

formatFromAcaoToCsv:-
    findall(acao(IdAcao,Nome,Preco,Div), acao(IdAcao,Nome,Preco,Div), Acoes),
    csv_write_file('Prolog/src/Investimento/acoes.csv', Acoes).
