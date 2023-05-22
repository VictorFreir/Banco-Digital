module Saque.Saque where

-- Saque
-- validacao de saldo e subtracao do total

-- exibeFuncionalidades
-- funcionalidadeID == 2

import Models.Conta as Conta
import Database.Database


sacar :: Conta -> IO()
sacar contaAtual = do
    putStrLn ("Saldo Atual: R$ " ++ show (pegaSaldo (cpf contaAtual)))
    putStrLn "Informe o valor que deseja sacar: "
    input <- getLine 
    let valor = read input
    if (saldo contaAtual > valor) 
    then do
        subtraiValor contaAtual valor
        putStrLn "Saque realizado com sucesso!"
    else do 
        erroValor

erroValor :: IO()
erroValor = do
    print "O valor desejado e superior ao valor disponivel em sua conta!"

subtraiValor :: Conta -> Float -> IO()
subtraiValor conta valor = do
    let novaConta = conta {saldo = (saldo conta) - valor}
    alterarSaldoNoCSV (cpf novaConta) (saldo novaConta)