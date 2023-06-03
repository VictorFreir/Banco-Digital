:- module(acoes, []).

acao(Nome,Preco,Dividendo)
acao(pixget,10.85,0.01).
acao(haiscompany,3.76,0.03).
acao(muquiff,1.49,0.08).

getPreco(Nome, Preco) :-
    acao(Nome, Preco, _).

novo_preco(Acao, NovoPreco) :-
    retract(acao(Acao, _, _)),
    assertz(acao(Acao, NovoPreco, _)).

calculaRendimento(ValorAtual, ValorNovo):-
    random(0, 3, Numero),
    (Numero =:= 0 -> ValorNovo is ValorAtual * 0.90 ; ValorNovo is ValorAtual * 1.10).

#daqui pra frente ta errado, nao pega certo depois eu ajeito

atualizaTodos:-
    acao(pixget,PrecoPG,0.01),
    acao(haiscompany,PrecoHC,0.03),
    acao(muquiff,PrecoMQ,0.08),
    calculaRendimento(PrecoPG, NPG),
    calculaRendimento(PrecoHC, PHC),
    calculaRendimento(PrecoMQ, PMQ),
    novo_preco(pixget, NPG),
    novo_preco(haiscompany, PHC),
    novo_preco(muquiff, PMQ).

printaAcoes:-
    getPreco(pixget, PrecoPG),
    getPreco(haiscompany,PrecoHC),
    getPreco(muquiff,PrecoMQ),
    write('1 - PixGet - Valor: R$ '), write(PrecoPG), write(' - Dividendos: 1%'), nl,
    write('2 - HaisCompany - Valor: R$ '), write(PrecoHC), write(' - Dividendos: 3%'), nl,
    write('3 - Muquiff - Valor: R$ '), write(PrecoMQ), write(' - Dividendos: 8%'), nl.

