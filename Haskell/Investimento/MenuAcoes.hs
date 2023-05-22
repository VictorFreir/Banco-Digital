module Investimento.MenuAcoes where

import Database.Database
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

selecionaFuncionalidadeAcoes :: String -> Conta -> [Acao] -> IO()
selecionaFuncionalidadeAcoes "1" conta acoes = do 
    putStrLn "Mostra de Acoes"
    printAcoes acoes
    execucaoRecur conta acoes
selecionaFuncionalidadeAcoes "2" conta acoes = do
    putStrLn "Comprar Acoes"
    comprarAcoes conta acoes
    execucaoRecur conta acoes
selecionaFuncionalidadeAcoes "3" conta acoes = do
    putStrLn "Vender Acoes"
    venderAcoes conta acoes
    execucaoRecur conta acoes
selecionaFuncionalidadeAcoes "4" conta acoes = do
    putStrLn "Suas acoes:"
    minhasAcoes conta acoes
    execucaoRecur conta acoes
selecionaFuncionalidadeAcoes "5" conta acoes = do
    putStrLn "Recuperar Dividendos:"
    recuperarDividendos conta acoes
    execucaoRecur conta acoes
selecionaFuncionalidadeAcoes "6" conta acoes = do
    putStrLn "Saindo."
    sair acoes

execucaoRecur :: Conta -> [Acao] -> IO()
execucaoRecur conta acoes = do
    putStrLn "O que deseja Fazer Agora?"
    exibeFuncionalidadesAcoes
    input <- getLine
    let acao = input
    let newConta = pegaContaPeloCPF (cpf conta)
    newAcao <- atualizaValorAcao acoes
    selecionaFuncionalidadeAcoes acao newConta newAcao
    
controleAcoes :: Conta -> IO ()
controleAcoes conta = do
    acoes <- readAcoes "./Investimento/acoes.csv"
    exibeFuncionalidadesAcoes
    input <- getLine
    let acao = input
    selecionaFuncionalidadeAcoes acao conta acoes