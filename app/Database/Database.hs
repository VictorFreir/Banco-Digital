module Database.Database where

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

import Data.Time.Format (formatTime, defaultTimeLocale)
import Models.Conta as Conta
import Models.Emprestimo as Emprestimo
import Text.CSV
import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Lazy.Char8 as BC
import GHC.Generics
import System.IO.Unsafe
import System.IO
import System.Directory
import Data.Time.Clock (UTCTime)
import Data.Time (UTCTime)
import GHC.Base (Float)

criaContaNoCSV :: String  -> Conta -> IO()
criaContaNoCSV diretorioDoCSV conta = do
    let p = contaParaCSV conta
    f <- openFile diretorioDoCSV AppendMode
    hPutStr f p
    hClose f

alterarEmprestimoNoCSV :: String -> Emprestimo -> IO()
alterarEmprestimoNoCSV cpfDaConta novoEmprestimo = do
  let path = "db.csv"
  let listaDeContasEmRecord = pegaContaDoCSV path
  let listaDeContas = recordParaConta listaDeContasEmRecord
  let contaOriginal = filtraContaPeloCPF cpfDaConta listaDeContas
  let contaAlterada = contaOriginal { emprestimo = novoEmprestimo }
  let novaListaDeContas = removeContaPeloCPF cpfDaConta listaDeContas ++ [contaAlterada]
  let listaDeContasCSV = "identificador,nome,numeroConta,cpf,dataNascimento,endereco,senha,perguntaSecreta,respostaSecreta,saldo,acao1,acao2,acao3,valorTotal,proximaParcela,dataProximaParcela,quantParcelasRestantes,taxaJuros" ++ listaDeContaParaCSV novaListaDeContas

  B.writeFile "tmp.csv" $ BC.pack listaDeContasCSV
  removeFile path
  renameFile "tmp.csv" path

pegaContaDoCSV :: String -> [Record]
pegaContaDoCSV path = do
    let file = unsafePerformIO( readFile path )
    let csvFile = parseCSV path file
    either csvParseError csvParseDone csvFile

pegaContaPeloCPF :: String -> Conta
pegaContaPeloCPF cpfBuscado = do
    let path = "db.csv"
    let csv = pegaContaDoCSV path
    let contas = recordParaConta csv
    let conta = filtraContaPeloCPF cpfBuscado contas
    conta

filtraContaPeloCPF :: String -> [Conta] -> Conta
filtraContaPeloCPF _ [] = do 
    let emprestimo = Emprestimo 0.0 0.0 (read "2020-01-01 00:00:00.000000 UTC" :: UTCTime) 0 0.0
    Conta 0 "" "" "" "2020-01-01" "" "" "" "" 0 [0,0,0] emprestimo
filtraContaPeloCPF cpfBuscado (x:xs)
    | (cpf x) == cpfBuscado = x
    | otherwise = filtraContaPeloCPF cpfBuscado xs

recordParaConta :: [Record] -> [Conta]
recordParaConta [] = []
recordParaConta (x:xs) = do
    let p = Conta (toInt $ x!!0) (x!!1) (x!!2) (x!!3) (x!!4) (x!!5) (x!!6) (x!!7) (x!!8) (read $ x!!9 :: Float) [(toInt $ x!!10), (toInt $ x!!11), (toInt $ x!!12)] (Emprestimo (read $ x!!13 :: Float) (read $ x!!14 :: Float) (read $ x!!15 :: UTCTime) (toInt $ x!!16) (read $ x!!17 :: Float))
    [p] ++ recordParaConta xs

toInt :: String -> Int
toInt n = read n :: Int

removeContaPeloCPF :: String -> [Conta] -> [Conta]
removeContaPeloCPF _ [] = []
removeContaPeloCPF cpfBuscado (x:xs)
    | (cpf x) == cpfBuscado = xs
    | otherwise = [x] ++ (removeContaPeloCPF cpfBuscado xs)

contaParaCSV :: Conta -> String
contaParaCSV conta = "\n" ++ (show $ identificador conta) ++ "," ++ (nome conta) ++ "," ++ (numeroConta conta) ++ "," ++ (cpf conta) ++ "," ++ (show $ dataNascimento conta) ++ "," ++ (endereco conta) ++ "," ++ (senha conta) ++ "," ++ (perguntaSecreta conta) ++ "," ++ (respostaSecreta conta) ++ "," ++ (show $ saldo conta) ++ "," ++ (show $ ((acoes conta)!!0)) ++ "," ++ (show $ ((acoes conta)!!1)) ++ "," ++ (show $ ((acoes conta)!!2)) ++ "," ++ (show $ (valorTotal (emprestimo conta))) ++ "," ++ (show $ (proximaParcela (emprestimo conta))) ++ "," ++ (show $ (dataProximaParcela (emprestimo conta))) ++ "," ++ (show $ (quantParcelasRestantes (emprestimo conta))) ++ "," ++ (show $ (taxaJuros (emprestimo conta)))

contaCSVParaConta :: [String] -> Conta
contaCSVParaConta csv = do
    let emprestimo = Emprestimo (read (csv!!13) :: Float) (read (csv!!14) :: Float) (read (csv!!15) :: UTCTime) (read (csv!!16) :: Int) (read (csv!!17) :: Float)
    Conta (read (csv!!0) :: Int) (csv!!1) (csv!!2) (csv!!3) (csv!!4) (csv!!5) (csv!!6) (csv!!7) (csv!!8) (read (csv!!9) :: Float) [(read (csv!!10) :: Int), (read (csv!!11) :: Int), (read (csv!!12) :: Int)] emprestimo

csvParseError csvFile = []
csvParseDone csvFile = tail csvFile

listaDeContaParaCSV :: [Conta] -> String
listaDeContaParaCSV [] = ""
listaDeContaParaCSV (x:xs) = do
    let p = contaParaCSV x
    p ++ (listaDeContaParaCSV xs)

alterarSaldoNoCSV :: String -> Float -> IO()
alterarSaldoNoCSV cpfDaConta novoSaldo = do
  let path = "db.csv"
  let listaDeContasEmRecord = pegaContaDoCSV path
  let listaDeContas = recordParaConta listaDeContasEmRecord
  let contaOriginal = filtraContaPeloCPF cpfDaConta listaDeContas
  let contaAlterada = contaOriginal { saldo = novoSaldo }
  let novaListaDeContas = removeContaPeloCPF cpfDaConta listaDeContas ++ [contaAlterada]
  let listaDeContasCSV = "identificador,nome,numeroConta,cpf,dataNascimento,endereco,senha,perguntaSecreta,respostaSecreta,saldo,acao1,acao2,acao3,valorTotal,proximaParcela,dataProximaParcela,quantParcelasRestantes,taxaJuros" ++ listaDeContaParaCSV novaListaDeContas

  B.writeFile "tmp.csv" $ BC.pack listaDeContasCSV
  removeFile path
  renameFile "tmp.csv" path

pegaSaldo :: String -> Float
pegaSaldo cpfDaConta = do
    let path = "db.csv"
    let listaDeContasEmRecord = pegaContaDoCSV path
    let listaDeContas = recordParaConta listaDeContasEmRecord
    let contaOriginal = filtraContaPeloCPF cpfDaConta listaDeContas
    saldo contaOriginal

pegaAcoes :: String -> [Int]
pegaAcoes cpfDaConta = do
    let path = "db.csv"
    let listaDeContasEmRecord = pegaContaDoCSV path
    let listaDeContas = recordParaConta listaDeContasEmRecord
    let contaOriginal = filtraContaPeloCPF cpfDaConta listaDeContas
    acoes contaOriginal

alteraAcoesNoCSV :: String -> [Int] -> IO()
alteraAcoesNoCSV cpfDaConta novasAcoes = do
  let path = "db.csv"
  let listaDeContasEmRecord = pegaContaDoCSV path
  let listaDeContas = recordParaConta listaDeContasEmRecord
  let contaOriginal = filtraContaPeloCPF cpfDaConta listaDeContas
  let contaAlterada = contaOriginal { acoes = novasAcoes }
  let novaListaDeContas = removeContaPeloCPF cpfDaConta listaDeContas ++ [contaAlterada]
  let listaDeContasCSV = "identificador,nome,numeroConta,cpf,dataNascimento,endereco,senha,perguntaSecreta,respostaSecreta,saldo,acao1,acao2,acao3,valorTotal,proximaParcela,dataProximaParcela,quantParcelasRestantes,taxaJuros" ++ listaDeContaParaCSV novaListaDeContas

  B.writeFile "tmp.csv" $ BC.pack listaDeContasCSV
  removeFile path
  renameFile "tmp.csv" path

pegaSenha :: String -> String
pegaSenha cpfDaConta = do
    let path = "db.csv"
    let listaDeContasEmRecord = pegaContaDoCSV path
    let listaDeContas = recordParaConta listaDeContasEmRecord
    let contaOriginal = filtraContaPeloCPF cpfDaConta listaDeContas
    senha contaOriginal

pegaPerguntaSecreta :: String -> String
pegaPerguntaSecreta cpfDaConta = do
    let path = "db.csv"
    let listaDeContasEmRecord = pegaContaDoCSV path
    let listaDeContas = recordParaConta listaDeContasEmRecord
    let contaOriginal = filtraContaPeloCPF cpfDaConta listaDeContas
    perguntaSecreta contaOriginal

pegaRespostaSecreta :: String -> String
pegaRespostaSecreta cpfDaConta = do
    let path = "db.csv"
    let listaDeContasEmRecord = pegaContaDoCSV path
    let listaDeContas = recordParaConta listaDeContasEmRecord
    let contaOriginal = filtraContaPeloCPF cpfDaConta listaDeContas
    respostaSecreta contaOriginal

alteraSenha :: String -> String -> IO()
alteraSenha cpfDaConta novaSenha = do
    let path = "db.csv"
    let listaDeContasEmRecord = pegaContaDoCSV path
    let listaDeContas = recordParaConta listaDeContasEmRecord
    let contaOriginal = filtraContaPeloCPF cpfDaConta listaDeContas
    let contaAlterada = contaOriginal { senha = novaSenha }
    let novaListaDeContas = removeContaPeloCPF cpfDaConta listaDeContas ++ [contaAlterada]
    let listaDeContasCSV = "identificador,nome,numeroConta,cpf,dataNascimento,endereco,senha,perguntaSecreta,respostaSecreta,saldo,acao1,acao2,acao3,valorTotal,proximaParcela,dataProximaParcela,quantParcelasRestantes,taxaJuros" ++ listaDeContaParaCSV novaListaDeContas
    
    B.writeFile "tmp.csv" $ BC.pack listaDeContasCSV
    removeFile path
    renameFile "tmp.csv" path

removeContaPeloCPFNoCSV :: String -> String -> IO()
removeContaPeloCPFNoCSV path cpfDaConta = do
    let listaDeContasEmRecord = pegaContaDoCSV path
    let listaDeContas = recordParaConta listaDeContasEmRecord
    let novaListaDeContas = removeContaPeloCPF cpfDaConta listaDeContas
    let listaDeContasCSV = "identificador,nome,numeroConta,cpf,dataNascimento,endereco,senha,perguntaSecreta,respostaSecreta,saldo,acao1,acao2,acao3,valorTotal,proximaParcela,dataProximaParcela,quantParcelasRestantes,taxaJuros" ++ (listaDeContaParaCSV novaListaDeContas)
    
    B.writeFile "tmp.csv" $ BC.pack listaDeContasCSV
    removeFile path
    renameFile "tmp.csv" path