module Database.Database () where


{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

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

data Conta = Conta {
 identificador :: Int,
 nome :: String,
 numeroConta :: String,
 cpf :: String,
 dataNascimento :: UTCTime,
 endereco :: String,
 senha :: String,
 perguntaSecreta :: String,
 respostaSecreta :: String,
 saldo :: Float
} deriving (Show, Generic)

criaContaNoCSV :: String  -> Conta -> IO()
criaContaNoCSV diretorioDoCSV conta = do
    let p = contaParaCSV conta
    f <- openFile diretorioDoCSV AppendMode
    hPutStr f p
    hClose f

pegaContaDoCSV :: String -> [Record]
pegaContaDoCSV path = do
    let file = unsafePerformIO( readFile path )
    let csvFile = parseCSV path file
    either csvParseError csvParseDone csvFile

pegaContaPeloCPF :: String -> [Conta] -> Conta
pegaContaPeloCPF _ [] = Conta (-1) "" "" "" (read "2023-01-01 00:00:00.000000 UTC" :: UTCTime) "" "" "" "" 0.0
pegaContaPeloCPF cpfBuscado (x:xs)
    | (show $ cpf x) == cpfBuscado = x
    | otherwise = pegaContaPeloCPF cpfBuscado xs

removeContaPeloCPF :: String -> [Conta] -> [Conta]
removeContaPeloCPF _ [] = []
removeContaPeloCPF cpfBuscado (x:xs)
    | (show $ cpf x) == cpfBuscado = xs
    | otherwise = [x] ++ (removeContaPeloCPF cpfBuscado xs)

contaParaCSV :: Conta -> String
contaParaCSV conta = "\n" ++ (show $ identificador conta) ++ "," ++ (nome conta) ++ "," ++ (numeroConta conta) ++ "," ++ (cpf conta) ++ "," ++ (show $ dataNascimento conta) ++ "," ++ (endereco conta) ++ "," ++ (senha conta) ++ "," ++ (perguntaSecreta conta) ++ "," ++ (respostaSecreta conta) ++ "," ++ (show $ saldo conta)

csvParseError csvFile = []
csvParseDone csvFile = tail csvFile