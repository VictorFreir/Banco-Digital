module Main where

import Login.MenuCadastro
import Login.MenuLogin
import Models.Conta
import Login.RecuperaSenha

main :: IO ()
main = menu

menu :: IO ()
menu = do
  putStrLn "Escolha uma opção:"
  putStrLn "1 - Cadastro"
  putStrLn "2 - Login"
  putStrLn "3 - Recuperar senha"
  putStrLn "4 - Sair"
  opcao <- getLine
  case opcao of
     "1" -> cadastrarCliente >> menu
     "2" -> fazerLogin >> menu
     "3" -> recuperaSenha >> menu
     "4" -> putStrLn "Saindo..." >> return()
     _   -> putStrLn "Opção inválida." >> menu




  



