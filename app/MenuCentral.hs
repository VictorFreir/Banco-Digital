module MenuCentral where

import System.Exit
import Models.Conta
import Investimento.MenuAcoes
import Database.Database (pegaContaPeloCPF, recordParaConta, pegaContaDoCSV, pegaSaldo)
import qualified System.Process as SP
import Transferencia.Transferencia (menuTransferencia) 
import Saque.Saque (sacar)
import Emprestimo.MetodosEmprestimo (menuEmprestimo)


menu :: String -> IO()
menu cpf = do 
    exibeFuncionalidades
    
    let conta = pegaContaPeloCPF cpf 

    input <- getLine
    let funcionalidadeID = input
    limpaConsole
    selecionaFuncionalidade funcionalidadeID conta
    
    menu cpf

exibeFuncionalidades :: IO()
exibeFuncionalidades = do
    putStrLn "Selecione a acao desejada com apenas o numero referente:"
    putStrLn "  1- Consultar Saldo"
    putStrLn "  2- Transferir"
    putStrLn "  3- Sacar"
    putStrLn "  4- Consultar extrato"
    putStrLn "  5- Poupanca"
    putStrLn "  6- Emprestimos"
    putStrLn "  7- Acoes" 
    putStrLn "  8- Sair"

selecionaFuncionalidade :: String -> Conta -> IO ()
selecionaFuncionalidade "1" conta = do 
   putStrLn ("Saldo Atual: R$ " ++ show (pegaSaldo (cpf conta)))
selecionaFuncionalidade "2" conta = do 
    menuTransferencia conta
selecionaFuncionalidade "3" conta = do 
    sacar conta
selecionaFuncionalidade "4" conta = do 
    putStrLn "Consulta de extrato selecionada"
selecionaFuncionalidade "5" conta = do 
    putStrLn "Poupança selecionada"
selecionaFuncionalidade "6" conta = do 
    menuEmprestimo conta
selecionaFuncionalidade "7" conta = do 
    controleAcoes conta
selecionaFuncionalidade "8" conta = do 
    putStrLn "Saindo do menu"
    exitSuccess
selecionaFuncionalidade _ conta= do 
    putStrLn "A opcao selecionada e invalida"

limpaConsole :: IO ()
limpaConsole = do
  _ <- SP.system "reset"
  return ()

menuCentral :: IO()
menuCentral = do
    putStrLn "Bem vindo, DigiBank!" 
    menu "11111111111"