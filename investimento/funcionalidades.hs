module Investimento.Funcionalidades where

import System.Directory
import Data.List (intercalate)
import System.IO (withFile, hSetNewlineMode, hPutStr)
import Investimento.Acoes
import Investimento.Rendimento
import Investimento.Dividendos

printAcoes :: [Acao] -> IO ()
printAcoes (x:y:z:xs) = do
    putStrLn $ "1 - PixGet - Valor: " ++ show (preco x) ++ " - Dividendos: 1%"
    putStrLn $ "2 - HaisCompany - Valor: " ++ show (preco y) ++ " - Dividendos: 3%"
    putStrLn $ "3 - Muquiff - Valor: " ++ show (preco z) ++ " - Dividendos: 8%"

comprarAcoes :: [Acao] -> IO ()
comprarAcoes acoes = do
    putStrLn "Qual acao voce deseja comprar? (responda com o Id Valido)"
    printAcoes acoes
    input <- getLine
    let acao = input
    if acao == "1" then
        -- todo
    else if acao == "2" then
        -- todo
    else if acao == "3" then
        -- todo
    else
        putStrLn "Acao invalida"

minhasAcoes :: [Acao] -> IO ()
minhasAcoes acoes = do
    putStrLn "Atualmente, suas acoes estao assim:"
    -- todo

venderAcoes :: [Acao] -> IO ()
venderAcoes acoes = do
    minhasAcoes acoes
    putStrLn "Qual acao voce deseja vender? (Responda com Id Valido)"
    input <- getLine
    let acao = input
    putStrLn "Quantas acoes dessa voce deseja vender?"
    input2 <- getLine
    let quantidade = read input2 :: Int
    -- todo

recuperarDividendos :: [Acao] -> IO ()
recuperarDividendos acoes = do
    putStrLn "Atualmente, suas funções ja pagaram em dividendos: R$"
    putStrLn "Retirando Este Valor..."
    -- todo
    putStrLn "Valor Retirado, conferir na conta."

sair :: [Acao] -> IO ()
sair acoes = do
    let linhas = map (\acao -> [show (idAcao acao), nome acao, show (preco acao), show (dividendYeld acao)]) acoes
    escreverCSV "acoes.csv" linhas


escreverCSV :: FilePath -> [[String]] -> IO ()
escreverCSV nomeArquivo linhas = withFile nomeArquivo WriteMode $ \arquivo -> do
    hSetNewlineMode arquivo universalNewlineMode -- define o modo de nova linha como universal para evitar problemas de compatibilidade
    hPutStr arquivo $ concatMap (intercalate ",") linhas -- concatena as linhas com vírgulas e escreve no arquivo
