:- include("../database.pl").

sacar(Cpf) :-
    consultarSaldo(Cpf, Saldo),
    write("O seu saldo atual e: "), write(Saldo),nl,
    write("Informe o valor que deseja sacar: "),
    read(Valor),
    (   Saldo >= Valor ->  
        NovoSaldo is Saldo - Valor, 
        alterarSaldo(Cpf,NovoSaldo),
        write("Saque realizado com sucesso!"),nl,
        write("O seu novo saldo e: "), write(NovoSaldo),nl
    ;   erroValor,
        sacar(Cpf)
    ).

erroValor :-
    write("O valor digitado e maior do que o valor disponivel. Tente novamente com o valor correto."), nl.

