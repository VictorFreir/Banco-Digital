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

data People = People {
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

