:- use_module(library(csv)).
:- dynamic conta/22.

id(1000).
incrementa_id :- retract(id(X)), Y is X + 1, assertz(id(Y)).
:- dynamic id/1.

% conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DiaProximaParcela, MesProximaParcela, AnoProximaParcela, QtdParcelasRestantes, TaxaJuros, ValorInvestido).

% Regra auxiliar
lerContasAux([]).
lerContasAux([row(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DiaProximaParcela, MesProximaParcela, AnoProximaParcela, QtdParcelasRestantes, TaxaJuros, ValorInvestido, Extrato)|T]) :-
    assertz(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DiaProximaParcela, MesProximaParcela, AnoProximaParcela, QtdParcelasRestantes, TaxaJuros, ValorInvestido, Extrato)),
    lerContasAux(T).

% Regra auxiliar
lerCSV(File) :-
    csv_read_file('./Prolog/resources/db.csv', File).

% Regra principal, precisa ser chamada para ler o arquivo
% Necessáio para que as contas sejam carregadas na memória
lerContas :-
    lerCSV(File),
    lerContasAux(File).

criaConta(Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DiaProximaParcela, MesProximaParcela, AnoProximaParcela, QtdParcelasRestantes, TaxaJuros, ValorInvestido, Extrato) :-
    id(ID), incrementa_id,
    assertz(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DiaProximaParcela, MesProximaParcela, AnoProximaParcela, QtdParcelasRestantes, TaxaJuros, ValorInvestido, Extrato)).

consultarSaldo(CPF, Saldo) :-
    conta(_, _, _, CPF, _, _, _, _, _, Saldo, _, _, _, _, _, _, _, _,_, _, _, _).

alterarSaldo(CPF, Saldo) :-
    retract(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, _, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DiaProximaParcela, MesProximaParcela, AnoProximaParcela, QtdParcelasRestantes, TaxaJuros, ValorInvestido, Extrato)),
    assertz(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DiaProximaParcela, MesProximaParcela, AnoProximaParcela, QtdParcelasRestantes, TaxaJuros, ValorInvestido, Extrato)).

pegaContaPeloCPF(Id, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DiaProximaParcela, MesProximaParcela, AnoProximaParcela, QtdParcelasRestantes, TaxaJuros, ValorInvestido, Extrato) :-
    conta(Id, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DiaProximaParcela, MesProximaParcela, AnoProximaParcela, QtdParcelasRestantes, TaxaJuros, ValorInvestido, Extrato).  

pegaAcao1(CPF, Acao1) :-
    conta(_, _, _, CPF, _, _, _, _, _, _, Acao1, _, _, _, _, _, _, _, _, _, _, _).

pegaAcao2(CPF, Acao2) :-
    conta(_, _, _, CPF, _, _, _, _, _, _, _, Acao2, _, _, _, _, _, _, _, _, _, _).

pegaAcao3(CPF, Acao3) :-
    conta(_, _, _, CPF, _, _, _, _, _, _, _, _, Acao3, _, _, _, _, _, _, _, _,_).

alterarAcao1(CPF, Acao1) :-
    retract(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, _, Acao2, Acao3, ValorTotal, ProximaParcela, DiaProximaParcela, MesProximaParcela, AnoProximaParcela, QtdParcelasRestantes, TaxaJuros, ValorInvestido, Extrato)),
    assertz(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DiaProximaParcela, MesProximaParcela, AnoProximaParcela, QtdParcelasRestantes, TaxaJuros, ValorInvestido, Extrato)).

alterarAcao2(CPF, Acao2) :-
    retract(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, _, Acao3, ValorTotal, ProximaParcela, DiaProximaParcela, MesProximaParcela, AnoProximaParcela, QtdParcelasRestantes, TaxaJuros, ValorInvestido, Extrato)),
    assertz(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DiaProximaParcela, MesProximaParcela, AnoProximaParcela, QtdParcelasRestantes, TaxaJuros, ValorInvestido, Extrato)).

alterarAcao3(CPF, Acao3) :-
    retract(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, _, ValorTotal, ProximaParcela, DiaProximaParcela, MesProximaParcela, AnoProximaParcela, QtdParcelasRestantes, TaxaJuros, ValorInvestido, Extrato)),
    assertz(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DiaProximaParcela, MesProximaParcela, AnoProximaParcela, QtdParcelasRestantes, TaxaJuros, ValorInvestido, Extrato)).

deletaConta(CPF) :-
    retract(conta(_, _, _, CPF, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _)).

alterarValorInvestido(CPF, NovoValorInvestido) :-
    retract(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DiaProximaParcela, MesProximaParcela, AnoProximaParcela, QtdParcelasRestantes, TaxaJuros, _)),
    assertz(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DiaProximaParcela, MesProximaParcela, AnoProximaParcela, QtdParcelasRestantes, TaxaJuros, NovoValorInvestido)).

consultarValorInvestido(CPF, ValorInvestido) :-
    conta(_, _, _, CPF, _, _, _, _, _, _, _, _, _, _, _, _, _,_,_,_, ValorInvestido,_).

consultarProximaParcela(CPF, ProximaParcela, DiaProximaParcela, MesProximaParcela, AnoProximaParcela) :-
    conta(_, _, _, CPF, _,_, _, _, _, _, _, _, _, _, ProximaParcela, DiaProximaParcela, MesProximaParcela, AnoProximaParcela, _, _, _, _).

alterarProximaParcela(CPF, ProximaParcela, DiaProximaParcela, MesProximaParcela, AnoProximaParcela) :-
    retract(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, _, _, _, _, QtdParcelasRestantes, TaxaJuros, ValorInvestido, Extrato)),
    assertz(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DiaProximaParcela, MesProximaParcela, AnoProximaParcela, QtdParcelasRestantes, TaxaJuros, ValorInvestido, Extrato)).

consultarExtrato(CPF, Extrato) :-
    conta(_, _, _, CPF, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, Extrato).

alterarExtrato(CPF, Extrato) :-
    retract(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DiaProximaParcela, MesProximaParcela, AnoProximaParcela, QtdParcelasRestantes, TaxaJuros, ValorInvestido, _)),
    assertz(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DiaProximaParcela, MesProximaParcela, AnoProximaParcela, QtdParcelasRestantes, TaxaJuros, ValorInvestido, Extrato)).

consultarQtdParcelasRestantes(CPF, QtdParcelasRestantes) :-
    conta(_, _, _, CPF, _, _, _, _, _, _, _, _, _, _, _, _, _, _, QtdParcelasRestantes, _, _, _).

consultarCPF(CPF) :-
    conta(_, _, _, CPF, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _) -> true; false.

consultarSenha(CPF, Senha) :-
    conta(_, _, _, CPF, _, _, Senha, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _).

consultarPerguntaSecreta(CPF, PerguntaSecreta, RespostaSecreta) :-
    conta(_, _, _, CPF, _, _, _, PerguntaSecreta, RespostaSecreta, _, _, _, _, _, _, _, _, _, _, _, _, _).

alterarSenha(CPF, NovaSenha) :-
    retract(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, _, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DiaProximaParcela, MesProximaParcela, AnoProximaParcela, QtdParcelasRestantes, TaxaJuros, ValorInvestido, Extrato)),
    assertz(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, NovaSenha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DiaProximaParcela, MesProximaParcela, AnoProximaParcela, QtdParcelasRestantes, TaxaJuros, ValorInvestido, Extrato)).

% Ao sair do programa, salva os dados no arquivo CSV
registrarDadosNoCSV :-
    findall(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DiaProximaParcela, MesProximaParcela, AnoProximaParcela, QtdParcelasRestantes, TaxaJuros, ValorInvestido, Extrato), conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DiaProximaParcela, MesProximaParcela, AnoProximaParcela, QtdParcelasRestantes, TaxaJuros, ValorInvestido, Extrato), Contas),
    csv_write_file('./Prolog/resources/db.csv', Contas).