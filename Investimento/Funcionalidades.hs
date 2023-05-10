module Investimento.Funcionalidades where

import System.Directory
import Data.List (intercalate)
import System.IO (withFile, IOMode(WriteMode), hSetNewlineMode, universalNewlineMode, hPutStr)
import Investimento.Acoes
import Text.Printf
import Investimento.Rendimento
import Investimento.Dividendos

formatDouble :: Double -> String
formatDouble = printf "%.2f"

printAcoes :: [Acao] -> IO ()
printAcoes (x:y:z:xs) = do
    putStrLn $ "1 - PixGet - Valor: R$ " ++ formatDouble (preco x) ++ " - Dividendos: 1%"
    putStrLn $ "2 - HaisCompany - Valor: R$ " ++ formatDouble (preco y) ++ " - Dividendos: 3%"
    putStrLn $ "3 - Muquiff - Valor: R$ " ++ formatDouble (preco z) ++ " - Dividendos: 8%"

comprarAcoes :: [Acao] -> IO ()
comprarAcoes (x:y:z:xs) = do
    putStrLn "Qual acao voce deseja comprar? (responda com o Id Valido)"
    printAcoes (x:y:z:xs)
    input <- getLine
    let acao = input
    putStrLn "Quantas acoes dessa voce deseja comprar?"
    input2 <- getLine
    let quantidade = read input2 :: Int
        valor = if acao == "1" then (preco x) * fromIntegral quantidade
                else if acao == "2" then (preco y) * fromIntegral quantidade
                else if acao == "3" then (preco z) * fromIntegral quantidade
                else 0 -- Define um valor padrão para a variável valor
    putStrLn ("Essa compra vai custar: R$ " ++ formatDouble valor)
    putStrLn "Continuar? (s/n)"
    input <- getLine
    let continua = input
    if continua == "s" then
        if acao == "1" then
            -- tira da conta valor
            -- pega o array de acoes na posição 0 e add quantidade
            putStrLn "Compra Realizada!"
        else if acao == "2" then
            -- tira da conta valor
            -- pega o array de acoes na posição 1 e add quantidade
            putStrLn "Compra Realizada!"
        else if acao == "3" then
            -- tira da conta valor
            -- pega o array de acoes na posição 2 e add quantidade
            putStrLn "Compra Realizada!"
        else
            putStrLn "Acao invalida"
    else putStrLn "ok!"


minhasAcoes :: [Acao] -> IO ()
minhasAcoes acoes = do
    putStrLn "Atualmente, suas acoes estao assim:"
    -- pega o array da mzr da conta
    -- mostra

venderAcoes :: [Acao] -> IO ()
venderAcoes (x:y:z:xs) = do
    minhasAcoes (x:y:z:xs)
    putStrLn "Qual acao voce deseja vender? (Responda com Id Valido)"
    input <- getLine
    let acao = input
    putStrLn "Quantas acoes dessa voce deseja vender?"
    input2 <- getLine
    let quantidade = read input2 :: Int
        valor = if acao == "1" then (preco x) * fromIntegral quantidade
                else if acao == "2" then (preco y) * fromIntegral quantidade
                else if acao == "3" then (preco z) * fromIntegral quantidade
                else 0 -- Define um valor padrão para a variável valor
    putStrLn ("Nesta venda voce vai lucrar: R$ " ++ formatDouble valor)
    putStrLn "Continuar? (s/n)"
    input <- getLine
    let continua = input
    if continua == "s" then
        if acao == "1" then
            -- tira da conta valor
            -- pega o array de acoes na posição 0 e add quantidade
            putStrLn "Venda Realizada!"
        else if acao == "2" then
            -- tira da conta valor
            -- pega o array de acoes na posição 1 e add quantidade
            putStrLn "Venda Realizada!"
        else if acao == "3" then
            -- tira da conta valor
            -- pega o array de acoes na posição 2 e add quantidade
            putStrLn "Venda Realizada!"
        else
            putStrLn "Acao invalida"
    else putStrLn "ok!"

recuperarDividendos :: [Acao] -> IO ()
recuperarDividendos (x:y:z:xs) = do
    putStrLn "Atualmente, suas funções ja pagaram em dividendos: R$"
    -- pega o array do cara e multiplica [0] com x [1] com y e [2] com z
    putStrLn "Retirando Este Valor..."
    -- adiciona na conta o valor
    putStrLn "Valor Retirado, conferir na conta."

sair :: [Acao] -> IO ()
sair acoes = do
    let linhas = map (\acao -> [show $ idAcao acao, nome acao, printf "%.2f" (preco acao), printf "%.2f" (dividendYeld acao) ++ "\n"]) acoes
    escreverCSV "./Investimento/acoes.csv" linhas


escreverCSV :: FilePath -> [[String]] -> IO ()
escreverCSV nomeArquivo linhas = withFile nomeArquivo WriteMode $ \arquivo -> do
    hSetNewlineMode arquivo universalNewlineMode -- define o modo de nova linha como universal para evitar problemas de compatibilidade
    hPutStr arquivo $ concatMap (intercalate ",") linhas -- concatena as linhas com vírgulas e escreve no arquivo
