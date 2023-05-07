
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
 dataNascimento :: UTCTime,
 endereco :: String,
 senha :: String,
 perguntaSecreta :: String,
 respotaSecreta :: String,
 saldo :: Float
} deriving (Show, Generic)

getContaPeloID :: Int-> [Conta] -> Conta
getContaPeloID _ [] = Conta (-1) ""
getContaPeloID identidicadorS (x:xs)
    | (identidicador x) == identidicadorS = x
    | otherwise = getContaPeloID identidicadorS xs

removeContaPeloID :: Int -> [Conta] -> [Conta]
removeContaPeloID _ [] = []
removeContaPeloID identidicadorS (x:xs)
    | (identidicador x) == identidicadorS = xs
    | otherwise = [x] ++ (removeContaPeloID identidicadorS xs)
