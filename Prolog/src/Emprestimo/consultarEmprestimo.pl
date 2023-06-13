:- dynamic conta/22.
:- use_module(library(date)).

menuConsultarEmprestimo(Cpf):-
    write("Bem vindo a area de emprestimos!"),nl,
    write("Para consultar seu emprestimo digite 1"),nl,
    write("Para voltar ao menu principal digite 0"),nl,
    read(Opcao),
    primeiroSeletorConsulta(Opcao,Cpf).

primeiroSeletorConsulta(1,Cpf):- 
    menuConsultar(Cpf).
    
primeiroSeletorConsulta(_,_):-
    sair(Cpf).

menuConsultar(Cpf):-
    write("Aqui esta o seu emprestimo:"),nl,
    consultarProximaParcela(Cpf,ValorParcela,_,_,_),
    calculaValorEmprestado(ValorParcela,ValorEmprestado),
    write("Valor emprestado: "),
    write(ValorEmprestado),nl,
    calculaValorTotalEmprestimo(ValorEmprestado,ValorTotalEmprestimo),
    write("Valor total a pagar: "),
    write(ValorTotalEmprestimo),nl,
    calcularValorParcela(Cpf,ValorParcela,NovoValorParcela),
    write("Valor da proxima parcela: "),
    write(NovoValorParcela),nl,
    consultarQtdParcelasRestantes(Cpf,QuantParcelas),
    write("Parcelas restantes: "),
    write(QuantParcelas),nl,
    menuPagar(Cpf,NovoValorParcela).

calculaValorEmprestado(ValorParcela,ValorEmprestado):-
    ValorEmprestado is (ValorParcela*10).

calculaValorTotalEmprestimo(ValorEmprestado,ValorTotalEmprestimo):-
    ValorTotalEmprestimo is ValorEmprestado*1.1.


menuPagar(Cpf,ValorParcela):-
    write("Voce deseja pagar a parcela atual?"),nl,
    write("Digite 1 para sim"),nl,
    write("Digite 0 para nao"),nl,
    read(Opcao),
    segundoSeletorConsulta(Opcao, Cpf, ValorParcela).

segundoSeletorConsulta(1, Cpf, ValorParcela):-
    pagar(Cpf,ValorParcela).

segundoSeletorConsulta(_,Cpf,_):-
    sair(Cpf).

pagar(Cpf,ValorParcela):-
    consultarSaldo(Cpf,Saldo),
    consultarProximaParcela(Cpf, ValorParcela, Dia, Mes, Ano),
    Saldo >= ValorParcela,!,realizarPagamento(Cpf, ValorParcela, Dia, Mes, Ano),
    Saldo < ValorParcela,!,mensagemSaldoInsuficiente.


realizarPagamento(Cpf, ValorParcela, Dia, Mes, Ano):-
    buscaNovoMes(Mes,NovoMes),
    buscaNovoAno(Ano,NovoMes,NovoAno),
    subtraiSaldo(Saldo,ValorParcela,NovoSaldo),
    consultarQtdParcelasRestantes(Cpf,QuantParcelas),
    write("Pagamento realizado com sucesso!"),
    alterarProximaParcela(Cpf,ValorParcela,Dia,Mes,Ano),
    novaQuantParcelas is QuantParcelas-1,
    alterarQtdParcelasRestantes(novaQuantParcelas),
    alterarSaldo(Cpf,NovoSaldo),
    sair(Cpf).

buscaNovoMes(12,1):-
    true.

buscaNovoMes(Mes,NovoMes):-
    NovoMes is Mes+1.

buscaNovoAno(Ano,0,NovoAno):-
    NovoAno is Ano+1.

buscaNovoAno(Ano,_,Ano):-
    true.

subtraiSaldo(Saldo,ValorTransferir,NovoSaldo):-
    NovoSaldo is Saldo-ValorTransferir.

sair(Cpf):- 
    menuFuncionalidades(Cpf).

calcularValorParcela(Cpf,ValorParcela,ValorFinalParcela):-
    consultarProximaParcela(Cpf,_,Dia,Mes,Ano),
    calcularMesesAtrasados(Mes,Ano, MesesAtrasados),
    ValorFinalParcela is (round(100*ValorParcela * ((1.1)**MesesAtrasados)))/100.

calcularMesesAtrasados(Mes,Ano,MesesAtrasados):-
    pegarDataAtual(_,MesAtual,AnoAtual),
    Temp is (AnoAtual-Ano)*12,
    MesesAtrasados is Temp+(MesAtual-Mes).

pegarDataAtual(Dia, Mes, Ano) :-
    get_time(Timestamp),
    stamp_date_time(Timestamp, DateTime, local),
    date_time_value(day, DateTime, Dia),
    date_time_value(month, DateTime, Mes),
    date_time_value(year, DateTime, Ano).

mensagemSaldoInsuficiente(Cpf):-
    write("O seu saldo e insfuficiente para o pagamento dessa parcela!"),
    sair(Cpf).