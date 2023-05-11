module Main where

import MenuCadastro
import MenuLogin
import Models.Conta

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
    "3" -> putStrLn "missing implementation"--recuperarSenha >> menu
    "4" -> putStrLn "Saindo..." >> return()
    _   -> putStrLn "Opção inválida." >> menu




  



