module Login.MenuLogin where

import Login.ValidaLogin
  
fazerLogin :: IO ()
fazerLogin = do
  putStrLn "Digite seu CPF:"
  cpf <- getLine
  --validaCpfLogin cpf
  putStrLn "Digite sua senha:"
  senha <- getLine
  putStrLn  "Efetuando login"
