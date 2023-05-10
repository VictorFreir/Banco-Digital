module Investimento.Funcionalidades where

import System.Directory
import Data.List (intercalate)
import System.IO (withFile, IOMode(WriteMode), hSetNewlineMode, universalNewlineMode, hPutStr)
import Investimento.Acoes
import Investimento.Rendimento
import Investimento.Dividendos

printAcoes :: [Acao] -> IO ()
printAcoes (x:y:z:xs) = do
    putStrLn $ "1 - PixGet - Valor: " ++ show (preco x) ++ " - Dividendos: 1%"
    putStrLn $ "2 - HaisCompany - Valor: " ++ show (preco y) ++ " - Dividendos: 3%"
    putStrLn $ "3 - Muquiff - Valor: " ++ show (preco z) ++ " - Dividendos: 8%"

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
    if acao == "1" then
        -- tira da conta valor
        -- pega o array de acoes na posição 0 e add quantidade
        print valor
    else if acao == "2" then
        -- tira da conta valor
        -- pega o array de acoes na posição 1 e add quantidade
        print valor
    else if acao == "3" then
        -- tira da conta valor
        -- pega o array de acoes na posição 2 e add quantidade
        print valor
    else
        putStrLn "Acao invalida"


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
    if acao == "1" then
        -- coloca na conta valor
        -- pega o array de acoes na posição 0 e subtrai quantidade
        print valor
    else if acao == "2" then
        -- coloca na conta valor
        -- pega o array de acoes na posição 1 e subtrai quantidade
        print valor
    else if acao == "3" then
        -- coloca na conta valor
        -- pega o array de acoes na posição 2 e subtrai quantidade
        print valor
    else
        putStrLn "Acao invalida"

recuperarDividendos :: [Acao] -> IO ()
recuperarDividendos (x:y:z:xs) = do
    putStrLn "Atualmente, suas funções ja pagaram em dividendos: R$"
    -- pega o array do cara e multiplica [0] com x [1] com y e [2] com z
    putStrLn "Retirando Este Valor..."
    -- adiciona na conta o valor
    putStrLn "Valor Retirado, conferir na conta."

sair :: [Acao] -> IO ()
sair acoes = do
    let linhas = map (\acao -> [show $ idAcao acao, nome acao, show $ preco acao, show $ dividendYeld acao]) acoes
    escreverCSV "./investimento/acoes.csv" linhas


escreverCSV :: FilePath -> [[String]] -> IO ()
escreverCSV nomeArquivo linhas = withFile nomeArquivo WriteMode $ \arquivo -> do
    hSetNewlineMode arquivo universalNewlineMode -- define o modo de nova linha como universal para evitar problemas de compatibilidade
    hPutStr arquivo $ concatMap (intercalate ",") linhas -- concatena as linhas com vírgulas e escreve no arquivo
