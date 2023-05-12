module Extrato.PegaExtrato where

colocaNoExtrato :: String -> String
colocaNoExtrato cpf = "./Extrato/" ++ cpf ++ ".csv"
    

cadastraNovaTransf :: String -> IO()
cadastraNovaTransf str = print str