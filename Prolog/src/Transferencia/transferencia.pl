:- dynamic conta/22.
:- include("../database.pl").

menuTransferencia(Cpf):-
    lerContas,
    write("Bem vindo a area de transferencia!"),nl,
    write("Para realizar uma transferencia digite 1"),nl,
    write("Para voltar ao menu principal digite 0"),nl,
    read(Opcao),
    primeiroSeletorTransferencia(Opcao,Cpf).

primeiroSeletorTransferencia(Opcao,Cpf):- 
    Opcao =:= 1,
    !,
    menuTransferir(Cpf).
    
primeiroSeletorTransferencia(Opcao,_):- 
    Opcao =:= 0,
    !,
    sair.
    
menuTransferir(Cpf):-
    write("Digite o CPF do destinatario:"),nl,
    read(CpfDestinatario),
    write("Digite o valor que voce deseja transferir:"), nl,
    read(ValorTransferir),
    validaEntradas(ValorTransferir, Cpf,CpfDestinatario).
    
%validaEntradas(_,_, CpfDestinatario):-
%    (\+buscaCpf(CpfDestinatario)) == true,!,
%    mensagemCpfInvalido.

validaEntradas(ValorTransferir, Cpf, CpfDestinatario):-
    consultarSaldo(Cpf, Saldo),
    Temp is Saldo - ValorTransferir,
    Temp >= 0,!,
    transferir(ValorTransferir,Cpf,CpfDestinatario).

validaEntradas(_, _, _):-
    mensagemSaldoInsuficiente.

transferir(ValorTransferir, Cpf, CpfDestinatario):-
    consultarSaldo(Cpf, Saldo),
    subtraiSaldo(Saldo,ValorTransferir,NovoSaldo),
    alterarSaldo(Cpf,NovoSaldo),
    consultarSaldo(CpfDestinatario,SaldoDestinatario),
    somaSaldo(SaldoDestinatario,ValorTransferir,NovoSaldoDestinatario),
	alterarSaldo(CpfDestinatario,NovoSaldoDestinatario),
    write("A transferencia foi realizada com sucesso!"),nl,
    sair.

sair:- 
    registrarDadosNoCSV.

mensagemSaldoInsuficiente:-
    write("A transferencia nao pode ser realizada, pois o saldo da conta e insuficiente!"),
    sair.

mensagemCpfInvalido:-
    write("A transferencia nao pode ser realizada, pois o CPF informado nao foi encontrado"),
    sair.

buscaCpf(Cpf):-
    true.
    %coloca funcao raniel aqui

subtraiSaldo(Saldo,ValorTransferir,NovoSaldo):-
    NovoSaldo is Saldo-ValorTransferir.

somaSaldo(Saldo,ValorTransferir,NovoSaldo):-
    NovoSaldo is Saldo+ValorTransferir.