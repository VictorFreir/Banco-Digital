module Investimento.MenuAcoes where


import Investimento.Acoes
import Investimento.Rendimento
import Investimento.Funcionalidades
    

exibeFuncionalidadesAcoes :: IO()
exibeFuncionalidadesAcoes = do
    putStrLn "Selecione a acao desejada com apenas o numero referente:"
    putStrLn "  1- Ver Ações Atualmente"
    putStrLn "  2- Comprar Acoes"
    putStrLn "  3- Vender Acoes"
    putStrLn "  4- Ver Minhas Acoes"
    putStrLn "  5- Resgatar Dividendos"
    putStrLn "  6- Sair"

selecionaFuncionalidade :: String -> IO[Acao] -> IO()
selecionaFuncionalidade "1" acoes = do 
    putStrLn "Mostra de Acoes"
    printAcoes acoes
    execucaoRecur acoes
selecionaFuncionalidade "2" acoes = do
    putStrLn "Comprar Acoes"
    comprarAcoes acoes
    execucaoRecur acoes
selecionaFuncionalidade "3" acoes = do
    putStrLn "Vender Acoes"
    venderAcoes acoes
    execucaoRecur acoes
selecionaFuncionalidade "4" acoes = do
    putStrLn "Suas acoes:"
    minhasAcoes acoes
    execucaoRecur acoes
selecionaFuncionalidade "5" acoes = do
    putStrLn "Recuperar Dividendos:"
    recuperarDividendos acoes
    execucaoRecur acoes
selecionaFuncionalidade "6" acoes = do
    putStrLn "Saindo."
    sair acoes

execucaoRecur :: IO [Acao] -> IO()
execucaoRecur acoes = do
    putStrLn "O que deseja Fazer Agora?"
    exibeFuncionalidadesAcoes
    input <- getLine
    let acao = input
    selecionaFuncionalidade acao (atualizaValorAcao acoes)
    
main :: IO()
main = do
    acoes <- readAcoes "acoes.csv"
    exibeFuncionalidadesAcoes
    input <- getLine
    let acao = input
    selecionaFuncionalidade acao acoes