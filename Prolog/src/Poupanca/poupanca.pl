:- include("../database.pl").

poupanca(Cpf) :-
    consultarSaldo(Cpf, Saldo),
    consultarValorInvestido(Cpf, ValorInvestido),
    write("Valor investido: "), write(ValorInvestido), nl,
    format("O seu investimento atualmente esta rendendo ~2f por mes", [ValorInvestido * 0.01]), nl,
    write("1- Investir"), nl,
    write("2- Retirar investimento"), nl,
    read(Escolha),
    (
        Escolha =:= 1 -> investe(Cpf)
        ; Escolha =:= 2 -> retiraInvestimento(Cpf)
        ; write("Opcao invalida, selecione 1 ou 2."), nl,
          poupanca(Cpf)
    ).

investe(Cpf) :-
    write("Informe o valor a investir: "), read(Valor),nl,
    consultarSaldo(Cpf, Saldo),
    consultarValorInvestido(Cpf, ValorInvestido),
    Saldo >= Valor ->
    (
        NovoSaldo is Saldo - Valor,
        NovoValorInvestido is ValorInvestido + Valor,
        alterarSaldo(Cpf, NovoSaldo), 
        alterarValorInvestido(Cpf, NovoValorInvestido),
        poupanca(Cpf)
    );
    erroValor,
    poupanca(Cpf).

retiraInvestimento(Cpf) :-
    write("Informe o valor a retirar do investimento: "), read(Valor),nl,
    consultarSaldo(Cpf, Saldo),
    consultarValorInvestido(Cpf, ValorInvestido),
    ValorInvestido >= Valor ->
    (
        NovoSaldo is Saldo + Valor,
        NovoValorInvestido is ValorInvestido - Valor,
        alterarSaldo(Cpf, NovoSaldo),
        alterarValorInvestido(Cpf, NovoValorInvestido)
    );
    erroValor,
    poupanca(Cpf).

erroValor :-
    write("O valor digitado e maior do que o valor disponivel. Tente novamente."), nl.