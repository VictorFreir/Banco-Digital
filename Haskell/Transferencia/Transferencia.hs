module Transferencia.Transferencia where

import Extrato.PegaExtrato (cadastraNovaTransf)
import Database.Database
import Models.Conta as Conta
import Data.Time.Clock (getCurrentTime, UTCTime)

import Database.Database (pegaContaPeloCPF, recordParaConta, pegaContaDoCSV)


menuTransferencia :: Conta -> IO ()
menuTransferencia contaAtual = do
    putStrLn "Bem vindo a area de transferencias!"
    putStrLn "Informe o valor a ser transferido: "
    input <- getLine
    let valor = read input
    if valor <= (saldo contaAtual) then do
        putStrLn "Para quem vai ser transferido?\nDigite o CPF apenas com numeros"
        input2 <- getLine
        let cpforigem = input2
        let contaDestinataria = pegaContaPeloCPF cpforigem
        if (cpf contaDestinataria) == "" then erroCpf else transferir contaAtual contaDestinataria valor
    else erroValor

erroCpf :: IO()
erroCpf = do
    print "O CPF informado nao corresponde a nenhuma conta."

erroValor :: IO()
erroValor = do
    print "O valor desejado e superior ao valor disponivel em sua conta!"

transferir :: Conta -> Conta -> Float -> IO ()
transferir contaSaida contaChegada valor = do
    let novaContaSaida = subtraiValor contaSaida valor
        novaContaChegada = somaValor contaChegada valor
    salvaConta novaContaSaida
    salvaConta novaContaChegada
    diaAtual <- pegarDiaAtual
    let dadosTransfSaida = (cpf contaSaida) ++ "-" ++ (cpf contaChegada) ++ "-" ++ (show ((-1)*valor)) ++ "-" ++(show diaAtual)
    cadastraNovaTransf dadosTransfSaida
    let dadosTransfChegada = (cpf contaSaida) ++ "-" ++ (cpf contaChegada) ++ "-" ++ (show valor) ++ "-" ++(show diaAtual)
    cadastraNovaTransf dadosTransfChegada

    putStrLn "Transferencia realizada com sucesso!"

subtraiValor :: Conta -> Float -> Conta
subtraiValor conta valor = do
    conta {saldo = (saldo conta) - valor}

somaValor :: Conta -> Float -> Conta
somaValor conta valor = do
    conta {saldo = (saldo conta) + valor}

salvaConta :: Conta -> IO ()
salvaConta conta = alterarSaldoNoCSV (cpf conta) (saldo conta)

pegarDiaAtual :: IO UTCTime
pegarDiaAtual = getCurrentTime >>= return
