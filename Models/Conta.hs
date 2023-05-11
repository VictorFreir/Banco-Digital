module Models.Conta where

import GHC.Generics
import Data.Time.Clock (UTCTime)
import Data.Time (UTCTime)
import GHC.Base (Float)
import Models.Emprestimo as Emprestimo

data Conta = Conta {
    identificador :: Int,
    nome :: String,
    numeroConta :: String,
    dataNascimento :: UTCTime,
    endereco :: String,
    senha :: String,
    perguntaSecreta :: String,
    respotaSecreta :: String,
    saldo :: Float,
    emprestimo :: Emprestimo
} deriving (Show, Eq)