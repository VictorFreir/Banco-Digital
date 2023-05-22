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
    cpf :: String,
    dataNascimento :: String,
    endereco :: String,
    senha :: String,
    perguntaSecreta :: String,
    respostaSecreta :: String,
    saldo :: Float,
    acoes :: [Int],
    emprestimo :: Emprestimo
} deriving (Show)