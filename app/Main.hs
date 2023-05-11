module Main where

import Investimento.MenuAcoes

exibeFuncionalidades :: IO()
exibeFuncionalidades = do
    print "Selecione a acao desejada com apenas o numero referente:"
    print "  1- Transferir"
    print "  2- Sacar"
    print "  3- Consultar extrato"
    print "  4- Poupanaa"
    print "  5- Emprestimos"
    print "  6- Acoes" 
    print "  7- Sair"

selecionaFuncionalidade :: String -> IO ()
selecionaFuncionalidade "1" = do 
    putStrLn "Transferencia selecionada"
selecionaFuncionalidade "2" = do 
    putStrLn "Saque selecionado"
selecionaFuncionalidade "3" = do 
    putStrLn "Consulta de extrato selecionada"
selecionaFuncionalidade "4" = do 
    putStrLn "Poupança selecionada"
selecionaFuncionalidade "5" = do 
    putStrLn "Emprestimos selecionados"
selecionaFuncionalidade "6" = do 
    putStrLn "Acoes selecionadas"
    controleAcoes
selecionaFuncionalidade "7" = do 
    putStrLn "Saindo do menu"
selecionaFuncionalidade _ = do 
    putStrLn "A opcao selecionada e invalida"

menu :: IO()
menu = do 
    exibeFuncionalidades
    input <- getLine
    let funcionalidadeID = input
    selecionaFuncionalidade funcionalidadeID
    menu

main :: IO()
main = do
    print "Bem vindo, DigiBank!"
    menu
