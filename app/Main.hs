module Main where

exibeFuncionalidades :: IO()
exibeFuncionalidades = do
    print "Selecione a ação desejada com apenas o número referente:"
    print "  1- Transferir"
    print "  2- Sacar"
    print "  3- Consultar extrato"
    print "  4- Poupança"
    print "  5- Empréstimos"
    print "  6- Ações" 
    print "  7- Sair"

selecionaFuncionalidade :: String -> String
selecionaFuncionalidade "1" = "Transferência selecionada"
selecionaFuncionalidade "2" = "Saque selecionado"
selecionaFuncionalidade "3" = "Consulta de extrato selecionada"
selecionaFuncionalidade "4" = "Poupança selecionada"
selecionaFuncionalidade "5" = "Empréstimos selecionados"
selecionaFuncionalidade "6" = "Ações selecionadas"
selecionaFuncionalidade "7" = "Saindo do menu"
selecionaFuncionalidade _ = "A opção selecionada é inválida"

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
