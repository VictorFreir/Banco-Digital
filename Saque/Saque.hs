module Saque.Saque where

-- Saque
-- validacao de saldo e subtracao do total

-- exibeFuncionalidades
-- funcionalidadeID == 2

import Models.Conta as Conta
import Database.Database


sacar :: Conta -> IO()
sacar contaAtual = do
    putStrLn "O seu saldo atual e: " ++ show saldo contaAtual
    putStrLn "Informe o valor que deseja sacar: "
    valor <- readLine :: Float
    if (saldo contaAtual > valor) 
    then do
        subtraiValor contaAtual valor
        putStrLn "Saque realizado com sucesso!"
    else do 
        erroValor
        sacar

erroValor :: IO()
erroValor = do
    print "O valor desejado e superior ao valor disponivel em sua conta!"

subtraiValor :: Conta -> Float -> IO()
subtraiValor conta valor = do
    let novaConta = conta {saldo = (saldo conta) - valor}
    alterarSaldoNoCSV (cpf novaConta) (saldo novaConta)