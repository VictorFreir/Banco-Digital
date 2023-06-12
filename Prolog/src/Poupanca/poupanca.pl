:- include("../database.pl").

poupanca(Cpf) :-
    consultarSaldo(Cpf, Saldo),
    consultarValorInvestido(Cpf, ValorInvestido),
    write("Valor investido: "), write(ValorInvestido), nl,
    format("O seu investimento atualmente esta rendendo ~2f por mes", [ValorInvestido * 0.01]),
    write("1- Investir"), nl,
    write("2- Retirar investimento"), nl,
    read(Comando),
    seletorPoupanca(Comando, Cpf).

seletorPoupanca(1, Cpf) :-
    write("Informe o valor a investir: "), read(Valor),
    Saldo >= Valor ->
    (
        NovoSaldo is Saldo - Valor,
        NovoValorInvestido is ValorInvestido + Valor,
        alterarSaldo(Cpf, NovoSaldo), 
        alterarValorInvestido(Cpf, NovoValorInvestido)
    );
    erroValor,
    poupanca(Cpf).

seletorPoupanca(2, Cpf) :-
    write("Informe o valor a retirar do investimento: "), read(Valor),
    ValorInvestido >= Valor ->
    (
        NovoSaldo is Saldo + Valor,
        NovoValorInvestido is ValorInvestido - Valor,
        alterarSaldo(Cpf, NovoSaldo),
        alterarValorInvestido(Cpf, NovoValorInvestido)
    );
    erroValor,
    poupanca(Cpf).

seletorPoupanca(_, Cpf):-
    write("Opcao invalida. Selecione entre as opcoes 1 e 2."), nl,
    poupanca(Cpf).

erroValor :-
    write("O valor digitado e maior do que o valor disponivel. Tente novamente."), nl.