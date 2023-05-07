module Main where

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

selecionaFuncionalidade :: String -> String
selecionaFuncionalidade "1" = "Transferencia selecionada"
selecionaFuncionalidade "2" = "Saque selecionado"
selecionaFuncionalidade "3" = "Consulta de extrato selecionada"
selecionaFuncionalidade "4" = "Poupança selecionada"
selecionaFuncionalidade "5" = "Emprestimos selecionados"
selecionaFuncionalidade "6" = "Acoes selecionadas"
selecionaFuncionalidade "7" = "Saindo do menu"
selecionaFuncionalidade _ = "A opcao selecionada e invalida"

menu :: IO()
menu = do 
    exibeFuncionalidades
    funcionalidadeID <- getLine
    let saida = selecionaFuncionalidade funcionalidadeID
    print saida
    menu

main :: IO()
main = do
    print "Bem vindo, DigiBank!"
    menu
