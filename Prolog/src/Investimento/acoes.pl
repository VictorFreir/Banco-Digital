:- module(acoes).
:- dynamic acao/4.
:- use_module(library(csv)).

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
    Valor is Preco * Quantidade,
    write('Valor total da compra: R$ '), write(Valor), nl,
    write('Digite 1 para confirmar ou 0 para cancelar:'), nl,
    read(Confirmacao),
    (Confirmacao =:= 1 -> 
        write('Compra realizada com sucesso!'); write('Compra cancelada!')),nl.

vendeAcoes(Cpf):- 
    minhasAcoes(Cpf),
    write('Digite o ID da acao que deseja vender:'), nl,
    read(IdAcao),
    write('Digite a quantidade de acoes que deseja vender:'), nl,
    read(Quantidade),
    acao(IdAcao, _, Preco, _), 
    Valor is Preco * Quantidade,
    write('Valor total da venda: R$ '), write(Valor), nl,
    write('Digite 1 para confirmar ou 0 para cancelar:'), nl,
    read(Confirmacao),
    (Confirmacao =:= 1 -> 
        write('Venda realizada com sucesso!'),nl,
        write('Voce recebeu R$ '), write(Valor), write(' em sua conta!')
        ; write('Venda cancelada!')),nl.

minhasAcoes(Cpf):-
    write('Atualmente, voce possui as seguintes acoes:'), nl,
    write('1 - PixGet - Quantidade: 100'), nl,
    write('2 - HaisCompany - Quantidade: 100'), nl,
    write('3 - Muquiff - Quantidade: 100'), nl.

resgatarDividendos(Cpf):-
    write('Valor total dos dividendos para ser recuperados: R$ '), write(Valor), nl,
    write('Digite 1 para confirmar ou 0 para cancelar:'), nl,
    read(Confirmacao),
    (Confirmacao =:= 1 -> 
        write('Dividendos resgatados com sucesso!'), nl,
        write('Voce recebeu R$ '), write(Valor), write(' em sua conta!'), nl
        ; write('Resgate cancelado!'), nl).


readFromCsvToAcao:-
    csv_read_file('Investimento/acoes.csv', Rows, [functor(acao), arity(4)]),
    maplist(assert, Rows).

formatFromAcaoToCsv:-
    findall(acao(IdAcao,Nome,Preco,Div), acao(IdAcao,Nome,Preco,Div), Acoes),
    csv_write_file('Investimento/acoes.csv', Acoes).
