module investimento.menuAcoes where
import investimento.acoes
import investimento.rendimento

printAcoes :: IO[Acoes] -> String -> String
printAcoes [] str = str
printAcoes (x:xs) str = do
    str ++ printAcoes xs ((id x) ++ "- " ++ (nome x) ++ " - Preco : " ++ (preco x) ++ "- Status Atual : " ++ (if (rendimento x) = 1 then "valorizando" else if (rendimento x) = -1 then "desvalorizando" else "constante") ++ " - Porcentagem em Dividendos : " ++ ((dividendYeld x)* 100) ++ "%. \n")

exibeFuncionalidadesAcoes :: IO()
exibeFuncionalidadesAcoes = do
    putStrLn "Selecione a acao desejada com apenas o numero referente:"
    putStrLn "  1- Ver Ações Atualmente"
    putStrLn "  2- Comprar Acoes"
    putStrLn "  3- Vender Acoes"
    putStrLn "  4- Ver Minhas Acoes"
    putStrLn "  5- Sair"

selecionaFuncionalidade :: String -> IO[Acao] -> IO()
selecionaFuncionalidade "1" acoes = do 
    putStrLn "Mostra de Acoes"
    putStrLn printAcoes acoes
selecionaFuncionalidade "2" = do
    putStrLn "Comprar Acoes"
selecionaFuncionalidade "3" = do
    putStrLn "Vender Acoes"
selecionaFuncionalidade "4" = do
    putStrLn "Suas acoes:"
selecionaFuncionalidade "5" = do
    putStrLn "Saindo."
    sair


main :: IO()
main = do
    acoes <- readAcoes "acoes.csv"
    exibeFuncionalidadesAcoes
    input <- getLine
    let acao = input
    selecionaFuncionalidade acao acoes