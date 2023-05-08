printAcoes :: Int -> String
printAcoes id = do
let nome = --pega do csv
let precoAcao = --pega do csv
let rendimento = -- epga do csv
let divYeld = --pega do csv
id ++ "- " ++ nome ++ " - Preco : " ++ precoAcao ++ "- Status Atual : " ++ rendimento ++ " - Porcentagem em Dividendos : " ++ (divYeld * 100) ++ "%."

exibeFuncionalidadesAcoes :: IO()
exibeFuncionalidadesAcoes = do
    putStrLn "Selecione a ação desejada com apenas o número referente:"
    putStrLn "  1- Ver Ações Atualmente"
    putStrLn "  2- Comprar Açôes"
    putStrLn "  3- Vender Ações"

selecionaFuncionalidade :: String -> String
selecionaFuncionalidade "1" = do 
    putStrLn "Mostra de Acoes"
    printAcoes
selecionaFuncionalidade "2" = do
    putStrLn ""
selecionaFuncionalidade "3" = do
    putStrLn ""