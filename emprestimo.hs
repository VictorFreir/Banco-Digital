{-# LANGUAGE TemplateHaskell #-}
import Models.Emprestimo as Emprestimo
import Models.People as Pessoa
import Data.Time.Calendar
import GHC.Base (IO)
import Data.Time.Clock (getCurrentTime, utctDay)
import Data.ByteString (getLine)



menu :: Pessoa -> IO
menu conta = if (temEmprestimo (selecionaEmprestimo conta)) then menuSolitica conta else menuConsulta (selecionaEmprestimo conta) --alterar


menuSolitica :: Pessoa -> IO
menuSolitica conta = do 
     putStrLn "Bem vindo a área de Empréstimos"
    if analiseCredito conta then do
        valorEmprestimo <- solicitarValor conta
        putStrLn "O valor disponível para você é " valorEmprestimo
        putStrLn "Você deseja realizar o empréstimo?"
        putStrLn "Digite 1, caso sim"
        putStrLn "Digite 2, caso não"
        opcao <- getLine
        if opcao == "1" then do
            solicitarEmprestimo valorEmprestimo
            putStrLn "Empréstimo realizado com sucesso!"
        else
            putStrLn "Empréstimo não realizado!"

    else do
        putStrLn "Atualmente, não temos propostas de empréstimo para o seu perfil. "


menuConsulta :: Emprestimo -> IO
menuConsulta conta  = do
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
    opcao <- getLine
    if (opcao == "1") then pagarParcela else naoPagarParcela

calcularFatura :: Emprestimo -> IO
calcularFatura emprestimo = (valorTotal emprestimo) + (( valorTotal emprestimo)* mesesAtrasados emprestimo)


mesesAtrasados :: Emprestimo -> utctDay
mesesAtrasados = mesesEntreDatas (pegarDiaAtual) (dataProximaParcela emprestimo)


pegarDiaAtual :: IO Day
pegarDiaAtual = utctDay <$> getCurrentTime

temEmprestimo :: Emprestimo -> Bool
temEmprestimo emprestimo = (read $ valorTotal emprestimo) != 0

mesesEntreDatas :: Day -> Day -> Integer
mesesEntreDatas d1 d2 = diffMonths
    where
        (y1, m1, _) = toGregorian d1
        (y2, m2, _) = toGregorian d2
        diffYears = fromIntegral (y2 - y1)
        diffMonths = (diffYears * 12) + fromIntegral (m2 - m1)

solicitarEmprestimo :: String -> IO
-- mostrar ao usuario se ele pode ter um emprestimo, se puder retorne quanto
-- o valor do emprestimo tem que ser multiplo de 100
-- vai criar o emprestimo se solicitado for


consultarEmprestimo :: String -> IO
-- vai retornar informações sobre o emprestimo
-- vai dar a opção de pagar o emprestimo
-- vai calcular se está atrasado e aplicar juros

analiseCredito :: String -> Float
-- vai fazer a analise do credito da pessoa para verificar se ela pode ter um empresimo

pagarParcela :: Emprestimo -> String
-- paga a parcela 
