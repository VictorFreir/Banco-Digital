:- module(acoes, []).

acao(Nome,Preco,Dividendo)
acao(pixget,10.85,0.01).
acao(haiscompany,3.76,0.03).
acao(muquiff,1.49,0.08).

novo_preco(Acao, NovoPreco) :-
    retract(acao(Acao, _, _)),
    assertz(acao(Acao, NovoPreco, _)).

calculaRendimento(ValorAtual, ValorNovo):-
    random(0, 3, Numero),
    (Numero =:= 0 -> ValorNovo is ValorAtual * 0.90 ; ValorNovo is ValorAtual * 1.10).

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

