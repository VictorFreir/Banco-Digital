:- use_module(library(csv)).
:- dynamic conta/18.

id(1).
incrementa_id :- retract(id(X)), Y is X + 1, assert(id(Y)).
:- dynamic id/1.

conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DataProximaParcela, QtdParcelasRestantes, TaxaJuros).

lerCSV :-
    csv_read_file('./Prolog/resources/db.csv', Rows, [functor(conta), arity(18)]),
    maplist(assert, Rows).

criaConta(Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DataProximaParcela, QtdParcelasRestantes, TaxaJuros) :-
    id(ID), incrementa_id,
    assert(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DataProximaParcela, QtdParcelasRestantes, TaxaJuros)).

alterarSaldo(CPF, Saldo) :-
    retract(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, _, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DataProximaParcela, QtdParcelasRestantes, TaxaJuros)),
    assert(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DataProximaParcela, QtdParcelasRestantes, TaxaJuros)).

pegaContaPeloCPF(Id, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DataProximaParcela, QtdParcelasRestantes, TaxaJuros) :-
    conta(Id, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DataProximaParcela, QtdParcelasRestantes, TaxaJuros).  

pegaAcao1(CPF, Acao1) :-
    conta(_, _, _, CPF, _, _, _, _, _, _, Acao1, _, _, _, _, _, _, _).

pegaAcao2(CPF, Acao2) :-
    conta(_, _, _, CPF, _, _, _, _, _, _, _, Acao2, _, _, _, _, _, _).

pegaAcao3(CPF, Acao3) :-
    conta(_, _, _, CPF, _, _, _, _, _, _, _, _, Acao3, _, _, _, _, _).

alterarAcao1(CPF, Acao1) :-
    retract(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, _, Acao2, Acao3, ValorTotal, ProximaParcela, DataProximaParcela, QtdParcelasRestantes, TaxaJuros)),
    assert(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DataProximaParcela, QtdParcelasRestantes, TaxaJuros)).

alterarAcao2(CPF, Acao2) :-
    retract(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, _, Acao3, ValorTotal, ProximaParcela, DataProximaParcela, QtdParcelasRestantes, TaxaJuros)),
    assert(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DataProximaParcela, QtdParcelasRestantes, TaxaJuros)).

alterarAcao3(CPF, Acao3) :-
    retract(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, _, ValorTotal, ProximaParcela, DataProximaParcela, QtdParcelasRestantes, TaxaJuros)),
    assert(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DataProximaParcela, QtdParcelasRestantes, TaxaJuros)).

deletaConta(CPF) :-
    retract(conta(_, _, _, CPF, _, _, _, _, _, _, _, _, _, _, _, _, _, _)).

registrarDadosNoCSV :-
    findall(conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DataProximaParcela, QtdParcelasRestantes, TaxaJuros), conta(ID, Nome, NumeroConta, CPF, DataNascimento, Endereco, Senha, PerguntaSecreta, RespostaSecreta, Saldo, Acao1, Acao2, Acao3, ValorTotal, ProximaParcela, DataProximaParcela, QtdParcelasRestantes, TaxaJuros), Contas),
    csv_write_file('./Prolog/resources/db.csv', Contas).

% Está com um bug ao alterar, ler e escrever no CSV
% O bug ele não altera e sim cria uma nova conta apenas com o saldo alterado e os demais nulos ([]).
% 
% Exemplo do CSV:
%
% 4,Marcelo,55789-964,10,15/06/1987,Rua dos bobos Nº 0,1234,Nome do gato,Saruê,950.0,0,0,0,0.0,200.0,07/2023,13,0.15
% [],[],[],10,[],[],[],[],[],8000,[],[],[],[],[],[],[],[]