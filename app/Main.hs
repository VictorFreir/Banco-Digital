module Main where

import Investimento.MenuAcoes
import Database.Database (pegaContaPeloCPF, recordParaConta, pegaContaDoCSV)
import qualified System.Process as SP
import Transferencia.Transferencia (menuTransferencia) 

menu :: String -> IO()
menu cpf = do 
    print "Bem vindo, DigiBank!"
    exibeFuncionalidades
    
    let contas_records = pegaContaDoCSV "db.csv"
    let contas = recordParaConta contas_records
    let conta = pegaContaPeloCPF cpf contas

    input <- getLine
    let funcionalidadeID = input
    limpaConsole
    selecionaFuncionalidade funcionalidadeID conta
    
    menu cpf

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

selecionaFuncionalidade :: String -> Conta -> IO ()
selecionaFuncionalidade "1" conta = do 
    menuTransferencia conta
selecionaFuncionalidade "2" conta = do 
    putStrLn "Saque selecionado"
selecionaFuncionalidade "3" conta = do 
    putStrLn "Consulta de extrato selecionada"
selecionaFuncionalidade "4" conta = do 
    putStrLn "Poupança selecionada"
selecionaFuncionalidade "5" conta = do 
    putStrLn "Emprestimos selecionados"
selecionaFuncionalidade "6" conta = do 
    controleAcoes conta
selecionaFuncionalidade "7" conta = do 
    putStrLn "Saindo do menu"
selecionaFuncionalidade _ = do 
    putStrLn "A opcao selecionada e invalida"

limpaConsole :: IO ()
limpaConsole = do
  _ <- SP.system "reset"
  return ()

main :: IO()
main = menu "11111111111"