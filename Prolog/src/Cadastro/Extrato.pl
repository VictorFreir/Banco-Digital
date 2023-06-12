:- include('../database.pl').

atualizaExtratoTransferencia(ValorTransferir, Cpf, CpfDestinatario) :-
    consultarExtrato(Cpf, ExtratoTransf),
    consultarExtrato(CpfDestinatario, ExtratoDep),
    format(atom(Transferencia), "Transferência no valor de ~2f realizada com sucesso para o CPF ~w.", [ValorTransferir, CpfDestinatario]),
    format(atom(Deposito), "Depósito no valor de ~2f recebido do usuário com CPF ~w.", [ValorTransferir, Cpf]),
    atom_concat(ExtratoTransf, Transferencia, NovoExtratoTransf),
    atom_concat(ExtratoDep, Deposito, NovoExtratoDep),
    alterarExtrato(Cpf, NovoExtratoTransf),
    alterarExtrato(CpfDestinatario, NovoExtratoDep).
