:- module(acoes).
:- dynamic acao/3.

acao(pixget,10.85,0.01).
acao(haiscompany,3.76,0.03).
acao(muquiff,1.49,0.08).

atualizaPrecoNaRegra(Acao, Preco):-
    retract(acao(Acao, _, _)),
    assert(acao(Acao, Preco, _)).

calculaRendimento(ValorAtual, ValorNovo):-
    random(0, 3, Numero),
    (Numero =:= 0 -> Valor is ValorAtual * 0.90 ; Valor is ValorAtual * 1.10),
    ValorNovo is round(Valor * 100) / 100.

#daqui pra frente ta errado, nao pega certo depois eu ajeito
getPreco(Acao, Preco):-
    acao(Acao, Preco, _).

atualizaTodos:-
    acao(pixget,PrecoPG,0.01),
    acao(haiscompany,PrecoHC,0.03),
    acao(muquiff,PrecoMQ,0.08),
    calculaRendimento(PrecoPG, NPG),
    calculaRendimento(PrecoHC, PHC),
    calculaRendimento(PrecoMQ, PMQ),
    atualizaPrecoNaRegra(pixget, NPG),
    atualizaPrecoNaRegra(haiscompany, PHC),
    atualizaPrecoNaRegra(muquiff, PMQ).

printAllAcoes:-
    acao(pixget,PrecoPG,0.01),
    acao(haiscompany,PrecoHC,0.03),
    acao(muquiff,PrecoMQ,0.08),
    write('1 - PixGet - Valor: R$ '), write(PrecoPG), write(' - Dividendos: 1%'), nl,
    write('2 - HaisCompany - Valor: R$ '), write(PrecoHC), write(' - Dividendos: 3%'), nl,
    write('3 - Muquiff - Valor: R$ '), write(PrecoMQ), write(' - Dividendos: 8%'), nl.


main:-
    printAllAcoes,
    atualizaTodos,
    printAllAcoes,
    atualizaTodos,
    printAllAcoes.
