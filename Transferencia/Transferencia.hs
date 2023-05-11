module Transferencia.Transferencia where

import Models.Conta as Conta
import Data.Time.Clock (getCurrentTime, UTCTime)

import Database.Database (pegaContaPeloCPF, recordParaConta, pegaContaDoCSV)


menuTransferencia :: Conta -> IO ()
menuTransferencia contaAtual = do
    putStrLn "Bem vindo a área de transferências!"
    putStrLn "Informe o valor a ser transferido: "
    valor <- readLine :: Float
    if valor < (show saldo contaAtual) then do
        putStrLn "Para quem vai ser transferido?\nDigite o CPF apenas com números"
        cpf <- getLine
        let contaDestinataria = encontraContaDestinataria cpf
        if (contaDestinataria cpf == 0) then erroCpf else transferir contaAtual contaDestinataria valor
    else erroValor

encontraContaDestinataria :: String -> Conta
encontraContaDestinataria cpf = contaDestinaria where
    contaDestinataria = pegaContaPeloCPF cpf

erroCpf :: IO()
erroCpf = do
    print "O CPF informado não corresponde a nenhuma conta."

erroValor :: IO()
erroValor = do
    print "O valor desejado é superior ao valor disponível em sua conta!"

transferir :: Conta -> Conta -> Float -> String
transferir contaSaida contaChegada valor = do
    let novaContaSaida = subtraiValor contaSaida valor
        novaContaChegada = somaValor contaChegada valor
    salvaConta novaContaSaida
    salvaConta novaContaChegada
    return "Transferência realizada com sucesso!"

subtraiValor :: Conta -> Float -> Conta
subtraiValor conta valor = do
    let identificadorConta = (show $ identificador conta)
    let nomeConta = (show $ nome conta)
    let cpfConta = (show $ cpf conta)
    let numeroContaConta = (show $ numeroConta conta)
    let dataNascimentoConta = (show $ dataNascimento conta)
    let enderecoConta = (show $ endereco conta)
    let senhaConta = (show $ senha conta)
    let perguntaSecretaConta = (show $ perguntaSecreta conta)
    let respostaSecretaConta = (show $ respostaSecreta conta)
    let saldoConta = (show $ saldo conta) - valor
    Conta identificadorConta nomeConta cpfConta numeroContaConta dataNascimentoConta enderecoConta senhaConta perguntaSecretaConta respostaSecretaConta saldoConta

somaValor :: Conta -> Float -> Conta
somaValor conta valor = do
    let identificadorConta = (show $ identificador conta)
    let nomeConta = (show $ nome conta)
    let cpfConta = (show $ cpf conta)
    let numeroContaConta = (show $ numeroConta conta)
    let dataNascimentoConta = (show $ dataNascimento conta)
    let enderecoConta = (show $ endereco conta)
    let senhaConta = (show $ senha conta)
    let perguntaSecretaConta = (show $ perguntaSecreta conta)
    let respostaSecretaConta = (show $ respostaSecreta conta)
    let saldoConta = (show $ saldo conta) + valor
    Conta identificadorConta nomeConta cpfConta numeroContaConta dataNascimentoConta enderecoConta senhaConta perguntaSecretaConta respostaSecretaConta saldoConta

salvaConta :: Conta -> IO
salvaConta = do
    putStrLn "Conta salva com sucesso"

pegarDiaAtual :: IO UTCTime
pegarDiaAtual = getCurrentTime >>= return
