module Investimento.Funcionalidades where

printAcoes :: IO[Acoes] -> IO()
printAcoes (x:y:z:xs) = do
    putStrLn "1 - PixGet - Valor: " ++ (preco x) ++ " - Dividendos: 1%"
    putStrLn "2 - HaisCompany - Valor: " ++ (preco y) ++ " - Dividendos: 3%"
    putStrLn "3 - Muquiff - Valor: " ++ (preco z) ++ " - Dividendos: 8%"

comprarAcoes :: IO[Acoes] -> IO()
comprarAcoes (x:y:z:xs) = do
    putStrLn "Qual acao voce deseja comprar? (responda com o Id Valido)"
    printAcoes (x:y:z:xs)
    input <- getLine
    let acao = input
    if acao == "1" then

    else if acao == "2" then

    else if acao == "3" then

    else

minhasAcoes :: IO[Acoes] -> IO()
minhasAcoes (x:y:z:xs) = do
    putStrLn "Atualmente, suas acoes estao assim:"
    --todo


venderAcoes :: IO[Acoes] -> IO()
venderAcoes (x:y:z:xs) = do
    minhasAcoes (x:y:z:xs)
    "Qual acao voce deseja vender? (Responda com Id Valido)"
    input <- getLine
    let acao = input
    "Quantas acoes dessa voce deseja vender?"
    let quantidade = input
    --todo

sair :: IO[Acoes] -> IO()
sair (x:y:z:xs) = do
    