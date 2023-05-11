module Investimento.Funcionalidades where

import Models.Conta
import Database.Database
import System.Directory
import Data.List (intercalate)
import System.IO (withFile, IOMode(WriteMode), hSetNewlineMode, universalNewlineMode, hPutStr)
import Investimento.Acoes
import Text.Printf
import Investimento.Rendimento
import Investimento.Dividendos

formatDouble :: Float -> String
formatDouble = printf "%.2f"

printAcoes :: [Acao] -> IO ()
printAcoes (x:y:z:xs) = do
    putStrLn $ "1 - PixGet - Valor: R$ " ++ formatDouble (preco x) ++ " - Dividendos: 1%"
    putStrLn $ "2 - HaisCompany - Valor: R$ " ++ formatDouble (preco y) ++ " - Dividendos: 3%"
    putStrLn $ "3 - Muquiff - Valor: R$ " ++ formatDouble (preco z) ++ " - Dividendos: 8%"

comprarAcoes :: Conta -> [Acao] -> IO ()
comprarAcoes conta (x:y:z:xs) = do
    putStrLn "Qual ação você deseja comprar? (responda com o Id válido)"
    printAcoes (x:y:z:xs)
    input <- getLine
    let acao = input
    if acao `notElem` ["1", "2", "3"] then
        putStrLn "Id inválido!" >> return ()
    else do
        putStrLn "Quantas ações dessa você deseja comprar?"
        input2 <- getLine
        let quantidade = read input2 :: Int
            valor = if acao == "1" then (preco x) * fromIntegral quantidade
                    else if acao == "2" then (preco y) * fromIntegral quantidade
                    else if acao == "3" then (preco z) * fromIntegral quantidade
                    else 0 -- Define um valor padrão para a variável valor
        putStrLn ("Essa compra vai custar: R$ " ++ formatDouble valor)
        let newSaldo = (saldo conta) - valor
        if newSaldo < 0.0 then
            putStrLn "Seu saldo é insuficiente!" >> return ()
        else do
            putStrLn ("Saldo atual: R$ " ++ show (saldo conta))
            putStrLn "Continuar? (s/n)"
            input <- getLine
            let continua = input
                listaAcoes = pegaAcoes (cpf conta)
            if continua == "s" then do
                if acao == "1" then do
                    alteraAcoesNoCSV (cpf conta) $ (listaAcoes !! 0 + quantidade) : tail listaAcoes
                    alterarSaldoNoCSV (cpf conta) newSaldo
                    putStrLn "Compra realizada!"
                else if acao == "2" then do
                    alteraAcoesNoCSV (cpf conta) $ head listaAcoes : (listaAcoes !! 1 + quantidade) : tail (tail listaAcoes)
                    alterarSaldoNoCSV (cpf conta) newSaldo
                    putStrLn "Compra realizada!"
                else if acao == "3" then do
                    alteraAcoesNoCSV (cpf conta) $ head listaAcoes : head (tail listaAcoes) : (listaAcoes !! 2 + quantidade) : []
                    alterarSaldoNoCSV (cpf conta) newSaldo
                    putStrLn "Compra realizada!"
                else
                    putStrLn "Ação inválida"
            else putStrLn "ok!"



minhasAcoes :: Conta -> [Acao] -> IO ()
minhasAcoes conta (x:y:z:xs) = do
    putStrLn "Atualmente, suas acoes estao assim:"
    let listaAcoes = pegaAcoes (cpf conta)
    putStrLn $ "1 - PixGet - Valor: R$ " ++ formatDouble (preco x) ++ " - Quantidade:"
    print (listaAcoes !! 0)
    putStrLn $ "2 - HaisCompany - Valor: R$ " ++ formatDouble (preco y) ++ " - Quantidade:"
    print (listaAcoes !! 1)
    putStrLn $ "3 - Muquiff - Valor: R$ " ++ formatDouble (preco z) ++ " - Quantidade:"
    print (listaAcoes !! 2)
    

venderAcoes :: Conta -> [Acao] -> IO ()
venderAcoes conta (x:y:z:xs) = do
    minhasAcoes conta (x:y:z:xs)
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
    putStrLn ("Nesta venda voce vai receber: R$ " ++ formatDouble valor)
    putStrLn "Continuar? (s/n)"
    input <- getLine
    let continua = input
    let listaAcoes = pegaAcoes (cpf conta)
    let newSaldo = (saldo conta) + valor
    if continua == "s" then do
        if acao == "1" then do
            alteraAcoesNoCSV (cpf conta) $ (listaAcoes !! 0 - quantidade) : tail listaAcoes
            alterarSaldoNoCSV (cpf conta) newSaldo
            putStrLn "Venda realizada!"
        else if acao == "2" then do
            alteraAcoesNoCSV (cpf conta) $ head listaAcoes : (listaAcoes !! 1 - quantidade) : tail (tail listaAcoes)
            alterarSaldoNoCSV (cpf conta) newSaldo
            putStrLn "Venda realizada!"
        else if acao == "3" then do
            alteraAcoesNoCSV (cpf conta) $ head listaAcoes : head (tail listaAcoes) : (listaAcoes !! 2 - quantidade) : []
            alterarSaldoNoCSV (cpf conta) newSaldo
            putStrLn "Venda realizada!"
        else
            putStrLn "Ação inválida"
    else putStrLn "ok!"

recuperarDividendos :: Conta -> [Acao] -> IO ()
recuperarDividendos conta (x:y:z:xs) = do
    putStrLn "Atualmente, suas funções ja pagaram em dividendos: R$"
    -- pega o array do cara e multiplica [0] com x [1] com y e [2] com z
    putStrLn "Retirando Este Valor..."
    -- adiciona na conta o valor
    putStrLn "Valor Retirado, conferir na conta."

sair :: [Acao] -> IO ()
sair acoes = do
    let linhas = map (\acao -> [show $ idAcao acao, nomeAcao acao, printf "%.2f" (preco acao), printf "%.2f" (dividendYeld acao) ++ "\n"]) acoes
    escreverCSV "./Investimento/acoes.csv" linhas


escreverCSV :: FilePath -> [[String]] -> IO ()
escreverCSV nomeArquivo linhas = withFile nomeArquivo WriteMode $ \arquivo -> do
    hSetNewlineMode arquivo universalNewlineMode -- define o modo de nova linha como universal para evitar problemas de compatibilidade
    hPutStr arquivo $ concatMap (intercalate ",") linhas -- concatena as linhas com vírgulas e escreve no arquivo
