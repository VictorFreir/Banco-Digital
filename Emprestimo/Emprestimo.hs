module Emprestimo.Emprestimo where

import Models.Emprestimo 

import Models.Conta as Conta
import Data.Time.Calendar
import GHC.Base (IO)
import Data.Time.Clock (getCurrentTime, utctDay)
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
        putStrLn "você pagará " (show % valorEmprestimoAPagar)
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

mesesAtrasados :: Emprestimo -> utctDay
mesesAtrasados emprestimo = mesesEntreDatas (pegarDiaAtual) (dataProximaParcela emprestimo)

pegarDiaAtual :: IO Day
pegarDiaAtual = utctDay <$> getCurrentTime

temEmprestimo :: Emprestimo -> Bool
temEmprestimo emprestimo = (read $ valorTotal emprestimo) /= 0

mesesEntreDatas :: Day -> Day -> Integer
mesesEntreDatas d1 d2 = diffMonths
    where
        (y1, m1, _) = toGregorian d1
        (y2, m2, _) = toGregorian d2
        diffYears = fromIntegral (y2 - y1)
        diffMonths = (diffYears * 12) + fromIntegral (m2 - m1)

solicitarValor :: Conta -> Float
soliticarValor conta = (valor conta) * 10

solicitarEmprestimo :: Conta -> Float -> IO
solicitarEmprestimo conta valor = do
    let novoEmprestimo = Emprestimo valor (valor/12) (proximaParcelaData pegarDiaAtual) 12 0.15
    let cpfConta = (cpf conta)
    alterarEmprestimoNoCSV cpfConta novoEmprestimo

analiseCredito :: Conta -> Float
analiseCredito conta = if (saldo conta) >= 100 then True else False

pagarParcela :: Conta -> Conta
pagarParcela conta = contaAtualizada where
    let emprestimo = emprestimo conta
    if ((quantParcelasRestantes emprestimo) == 1) then do
        let emprestimoAtualizado = Emprestimo 0.0 0.0 pegarDiaAtual 0 0.0
    else do
        let emprestimoAtualizado = Emprestimo (valorTotal emprestimo) (proximaParcela emprestimo) (novaDataParcela (dataProximaParcela emprestimo)) (quantParcelasRestantes empresitmo)-1 (taxaJuros emprestimo)
    alterarEmprestimoNoCSV (cpf conta) emprestimoAtualizado

calcularValorTotal :: Conta -> Float
calcularValorTotal conta = (solicitarValor conta) * 1.15

proximaParcelaData :: UTCTime -> UTCTime
proximaParcela data = addUTCTime (30*24*60*60) data

naoPagarParcela :: IO()
naoPagarParcela = do
    print "A Parcela não foi paga!"