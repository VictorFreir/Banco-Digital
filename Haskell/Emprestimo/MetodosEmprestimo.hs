module Emprestimo.MetodosEmprestimo where

import Models.Emprestimo 

import Models.Conta as Conta
import Data.Time.Calendar
import GHC.Base (IO)
import Data.Time.Clock (getCurrentTime, utctDay, UTCTime)
import Data.ByteString (getLine)
import Database.Database

menuEmprestimo :: Conta -> IO()
menuEmprestimo conta = if (temEmprestimo conta) then menuSolitica conta else menuConsulta conta

menuSolitica :: Conta -> IO()
menuSolitica conta = do 
    putStrLn "Bem vindo a área de Empréstimos"
    if analiseCredito conta then do
        valorEmprestimo <- solicitarValor conta
        putStrLn "O valor disponível para você é " valorEmprestimo
        valorEmprestimoAPagar <- calcularValorTotal
        putStrLn "você pagará " (show valorEmprestimoAPagar)
        putStrLn "Você deseja realizar o empréstimo?"
        putStrLn "Digite 1, caso sim"
        putStrLn "Digite 2, caso não"
        opcao <- Prelude.getLine
        let escolha = opcao
        if escolha == "1" then do
            solicitarEmprestimo conta valorEmprestimo
            putStrLn "Empréstimo realizado com sucesso!"
        else
            putStrLn "Empréstimo não realizado!"

    else do
        putStrLn "Atualmente, não temos propostas de empréstimo para o seu perfil. "

menuConsulta :: Conta -> IO()
menuConsulta conta = do
    emprestimo <- emprestimo conta
    putStrLn "Bem vindo a área de Empréstimos!"
    putStrLn "Aqui estão as informações do seu empréstimo:"
    putStrLn "Valor total do empréstimo: " (show $ valorTotal emprestimo)
    putStrLn "Quantidade restante de parcelas: " (show $ quantParcelasRestantes emprestimo)
    putStrLn "Proxima parcela: " (show $ proximaParcela emprestimo)
    valorProximaFatura <- calcularFatura emprestimo
    putStrLn "Valor da parcela: " valorProximaFatura
    putStrLn "Deseja pagar ela?"
    putStrLn "selecione apenas com o número:"
    putStrLn "1- Para pagar"
    putStrLn "0- Para não pagar"
    opcao <- Prelude.getLine
    if (opcao == "1") then pagarParcela conta else naoPagarParcela

calcularFatura :: Emprestimo -> IO ()
calcularFatura emprestimo = if ((mesesAtrasados emprestimo) > 0) then (proximaParcela emprestimo) + ((proximaParcela emprestimo) * mesesAtrasados emprestimo) else (proximaParcela emprestimo)

mesesAtrasados :: Emprestimo -> Integer
mesesAtrasados emprestimo = do 
    diaAtual <- pegarDiaAtual
    let dayAi = utctDay (dataProximaParcela emprestimo)
    mesesEntreDatas diaAtual dayAi

pegarDiaAtual :: IO Day
pegarDiaAtual = utctDay <$> getCurrentTime

temEmprestimo :: Emprestimo -> Bool
temEmprestimo emprestimo = (read $ valorTotal emprestimo) /= 0

mesesEntreDatas :: UTCTime -> UTCTime -> Int
mesesEntreDatas d1 d2 =
  let (y1, m1, _) = toGregorian $ utctDay d1
      (y2, m2, _) = toGregorian $ utctDay d2
      monthsDiff = (y1 - y2) * 12 + (fromIntegral m1 - fromIntegral m2)
      -- ajuste caso d2 seja anterior a d1
      sign = if monthsDiff < 0 then -1 else 1
  in sign * monthsDiff

solicitarValor :: Conta -> Float
solicitarValor conta = (saldo conta) * 10.0

solicitarEmprestimo :: Conta -> Float -> IO ()
solicitarEmprestimo conta valor = do
    diaAtual <- pegarDiaAtual
    let novoEmprestimo = Emprestimo valor (valor/12) (proximaParcelaData diaAtual) 12 0.15
    let cpfConta = (cpf conta)
    alterarEmprestimoNoCSV cpfConta novoEmprestimo

analiseCredito :: Conta -> Float
analiseCredito conta = if (saldo conta) >= 100 then True else False

pagarParcela :: Conta -> IO()
pagarParcela conta = do
    let emprestimo = emprestimo conta
    if ((quantParcelasRestantes emprestimo) == 1) then do
        let emprestimoAtualizado = Emprestimo 0.0 0.0 pegarDiaAtual 0 0.0
        alterarEmprestimoNoCSV (cpf conta) emprestimoAtualizado
    else do
        let emprestimoAtualizado = Emprestimo (valorTotal emprestimo) (proximaParcela emprestimo) (novaDataParcela (dataProximaParcela emprestimo)) (quantParcelasRestantes empresitmo)-1 (taxaJuros emprestimo)
        alterarEmprestimoNoCSV (cpf conta) emprestimoAtualizado
    

calcularValorTotal :: Conta -> Float
calcularValorTotal conta = (solicitarValor conta) * 1.15

proximaParcelaData :: UTCTime -> UTCTime
proximaParcelaData dataProxima = addUTCTime (30*24*60*60) dataProxima

naoPagarParcela :: IO()
naoPagarParcela = do
    print "A Parcela não foi paga!"