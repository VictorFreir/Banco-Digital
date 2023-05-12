module Extrato.PegaExtrato where

colocaNoExtrato :: String -> String
colocaNoExtrato cpf = do
    let caminho = "./Extrato/" ++ cpf ++ ".csv"
    --escreve a transferencia no caminho

cadastraNovaTransf :: String -> IO()
cadastraNovaTransf = do
    print ""