module Investimento.MenuAcoes where


import Investimento.Acoes
import Investimento.Rendimento
import Investimento.Funcionalidades 
import Models.Conta
    

exibeFuncionalidadesAcoes :: IO()
exibeFuncionalidadesAcoes = do
    putStrLn "Selecione a acao desejada com apenas o numero referente:"
    putStrLn "  1- Ver Ações Atualmente"
    putStrLn "  2- Comprar Acoes"
    putStrLn "  3- Vender Acoes"
    putStrLn "  4- Ver Minhas Acoes"
    putStrLn "  5- Resgatar Dividendos"
    putStrLn "  6- Sair"

selecionaFuncionalidadeAcoes :: String -> [Acao] -> IO()
selecionaFuncionalidadeAcoes "1" acoes = do 
    putStrLn "Mostra de Acoes"
    printAcoes acoes
    execucaoRecur acoes
selecionaFuncionalidadeAcoes "2" acoes = do
    putStrLn "Comprar Acoes"
    comprarAcoes acoes
    execucaoRecur acoes
selecionaFuncionalidadeAcoes "3" acoes = do
    putStrLn "Vender Acoes"
    venderAcoes acoes
    execucaoRecur acoes
selecionaFuncionalidadeAcoes "4" acoes = do
    putStrLn "Suas acoes:"
    minhasAcoes acoes
    execucaoRecur acoes
selecionaFuncionalidadeAcoes "5" acoes = do
    putStrLn "Recuperar Dividendos:"
    recuperarDividendos acoes
    execucaoRecur acoes
selecionaFuncionalidadeAcoes "6" acoes = do
    putStrLn "Saindo."
    sair acoes

execucaoRecur :: [Acao] -> IO()
execucaoRecur acoes = do
    putStrLn "O que deseja Fazer Agora?"
    exibeFuncionalidadesAcoes
    input <- getLine
    let acao = input
    newAcao <- atualizaValorAcao acoes
    selecionaFuncionalidadeAcoes acao newAcao
    
controleAcoes :: Conta -> IO ()
controleAcoes conta = do
    acoes <- readAcoes "./Investimento/acoes.csv"
    exibeFuncionalidadesAcoes
    input <- getLine
    let acao = input
    selecionaFuncionalidadeAcoes acao acoes