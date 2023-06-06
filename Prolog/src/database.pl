:- use_module(library(csv)).

% conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DataProximaParcela, QtdParcelasRestantes, TaxaJuros).


id(1).
incrementa_id :- retract(id(X)), Y is X + 1, assert(id(Y)).
:- dynamic id/1.

% Lendo arquivo CSV
lerCSV(FilePath, File) :- csv_read_file(FilePath, File).

exibirContasAux([]).
exibirContasAux([row(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DataProximaParcela, QtdParcelasRestantes, TaxaJuros)|T]) :-
    write("ID:"), writeln(ID),
    write("Nome: "), writeln(Nome),
    write("Numero da conta: "), writeln(NumeroConta),
    write("CPF: "), writeln(CPF),
    write("Data de nascimento: "), writeln(DataNascimento),
    write("Endereco: "), writeln(Endereco),
    write("Senha: "), writeln(Senha),
    write("Pergunta secreta: "), writeln(PerguntaSecreta),
    write("Resposta secreta: "), writeln(RespostaSecreta),
    write("Saldo: "), writeln(Saldo),
    write("Acao 1: "), writeln(Acao1),
    write("Acao 2: "), writeln(Acao2),
    write("Acao 3: "), writeln(Acao3),
    write("Valor total: "), writeln(ValorTotal),
    write("Proxima parcela: "), writeln(ProximaParcela),
    write("Data da proxima parcela: "), writeln(DataProximaParcela),
    write("Quantidade de parcelas restantes: "), writeln(QtdParcelasRestantes),
    write("Taxa de juros: "), writeln(TaxaJuros),
    nl, exibirContasAux(T).

exibirContas() :-
   lerCSV('./Prolog/resources/db.csv', [_|File]),
   exibirContasAux(File).

criaContaNoCSV(Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DataProximaParcela, QtdParcelasRestantes, TaxaJuros) :-
   id(ID), incrementa_id,
   lerCSV('./Prolog/resources/db.csv', File),
   append(File, [row(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DataProximaParcela, QtdParcelasRestantes, TaxaJuros)], Saida),
   csv_write_file('./Prolog/resources/db.csv', Saida).

pegaContaPeloCPF(CPF) :- 
    lerCSV('./Prolog/resources/db.csv', File),
    pegaContaPeloCPFAux(File, CPF).

pegaContaPeloCPFAux(File, CPF) :-
    member(row(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DataProximaParcela, QtdParcelasRestantes, TaxaJuros), File),
    write('ID: '), writeln(ID),
    write('Nome: '), writeln(Nome),
    write('Numero da conta: '), writeln(NumeroConta),
    write('CPF: '), writeln(CPF),
    write('Data de nascimento: '), writeln(DataNascimento),
    write('Endereco: '), writeln(Endereco),
    write('Senha: '), writeln(Senha),
    write('Pergunta secreta: '), writeln(PerguntaSecreta),
    write('Resposta secreta: '), writeln(RespostaSecreta),
    write('Saldo: '), writeln(Saldo),
    write('Acao 1: '), writeln(Acao1),
    write('Acao 2: '), writeln(Acao2),
    write('Acao 3: '), writeln(Acao3),
    write('Valor total: '), writeln(ValorTotal),
    write('Proxima parcela: '), writeln(ProximaParcela),
    write('Data da proxima parcela: '), writeln(DataProximaParcela),
    write('Quantidade de parcelas restantes: '), writeln(QtdParcelasRestantes),
    write('Taxa de juros: '), writeln(TaxaJuros),
    nl.
    
    
alterarSaldoNoCSV([], _, _, []).
alterarSaldoNoCSV([row(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, _, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DataProximaParcela, QtdParcelasRestantes, TaxaJuros)|T], CPF, Saldo, [row(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DataProximaParcela, QtdParcelasRestantes, TaxaJuros)|T]).
alterarSaldoNoCSV([H|T], CPF, Saldo, [H|Out]) :- alterarSaldoNoCSV(T, CPF, Saldo, Out).

alterarSaldo(CPF, Saldo) :-
   lerCSV('./Prolog/resources/db.csv', File),
   alterarSaldoNoCSV(File, CPF, Saldo, Saida),
   csv_write_file('./Prolog/resources/db.csv', Saida).


