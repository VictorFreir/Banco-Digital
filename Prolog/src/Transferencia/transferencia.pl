:- dynamic conta/22.
:- include("../database.pl").
:- include("../Cadastro/Extrato.pl").

menuTransferencia(Cpf):-
    write("Bem vindo a area de transferencia!"),nl,
    write("Para realizar uma transferencia digite 1"),nl,
    write("Para voltar ao menu principal digite 0"),nl,
    read(Opcao),
    primeiroSeletorTransferencia(Opcao,Cpf).

primeiroSeletorTransferencia(Opcao,Cpf):- 
    Opcao =:= 1,
    !,
    menuTransferir(Cpf).
    
primeiroSeletorTransferencia(Opcao,Cpf):- 
    Opcao =:= 0,
    !,
    sair(Cpf).
    
menuTransferir(Cpf):-
    write("Digite o CPF do destinatario:"),nl,
    read(CpfDestinatario),
    write("Digite o valor que voce deseja transferir:"), nl,
    read(ValorTransferir),
    validaEntradas(ValorTransferir, Cpf,CpfDestinatario).
    
validaEntradas(_,Cpf, CpfDestinatario):-
    (\+buscaCpf(CpfDestinatario)) == true,!,
     mensagemCpfInvalido(Cpf).

validaEntradas(ValorTransferir, Cpf, CpfDestinatario):-
    consultarSaldo(Cpf, Saldo),
    Temp is Saldo - ValorTransferir,
    Temp >= 0,!,
    transferir(ValorTransferir,Cpf,CpfDestinatario).

validaEntradas(_, Cpf, _):-
    mensagemSaldoInsuficiente(Cpf).

transferir(ValorTransferir, Cpf, CpfDestinatario):-
    consultarSaldo(Cpf, Saldo),
    subtraiSaldo(Saldo,ValorTransferir,NovoSaldo),
    alterarSaldo(Cpf,NovoSaldo),
    consultarSaldo(CpfDestinatario,SaldoDestinatario),
    somaSaldo(SaldoDestinatario,ValorTransferir,NovoSaldoDestinatario),
	alterarSaldo(CpfDestinatario,NovoSaldoDestinatario),
    write("A transferencia foi realizada com sucesso!"),nl,
    atualizaExtratoTransferencia(ValorTransferir, Cpf, CpfDestinatario),
    sair(Cpf).

sair(Cpf):- 
    menuFuncionalidades(Cpf).

mensagemSaldoInsuficiente(Cpf):-
    write("A transferencia nao pode ser realizada, pois o saldo da conta e insuficiente!"), nl,
    sair(Cpf).

mensagemCpfInvalido(Cpf):-
    write("A transferencia nao pode ser realizada, pois o CPF informado nao foi encontrado"), nl,
    sair(Cpf).

buscaCpf(Cpf):-
    consultarCPF(Cpf).


subtraiSaldo(Saldo,ValorTransferir,NovoSaldo):-
    NovoSaldo is Saldo - ValorTransferir.

somaSaldo(Saldo,ValorTransferir,NovoSaldo):-
    NovoSaldo is Saldo + ValorTransferir.