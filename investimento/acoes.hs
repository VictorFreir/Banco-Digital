{-# LANGUAGE DeriveGeneric #-}

module Investimento.Acoes where
import Text.CSV (parseCSVFromFile)
import Investimento.Rendimento
import GHC.Generics

data Acao = Acao { idAcao :: Int, nome :: String, preco :: Double, dividendYeld :: Double } deriving (Show, Generic)
    
-- Função para converter uma linha de CSV em um objeto Acao
fromCsv :: [String] -> Maybe Acao
fromCsv [i, n, p, d] = Just $ Acao (read i) n (read p) (read d)
fromCsv _      = Nothing
    
-- Função para ler o arquivo CSV e retornar uma lista de Acoes
readAcoes :: FilePath -> IO [Acao]
readAcoes file = do
  csvData <- parseCSVFromFile file
  case csvData of
    Left err -> fail $ show err
    Right rows -> case mapM fromCsv (tail rows) of
      Nothing -> fail "Falha ao converter CSV"
      Just acoes -> return acoes

atualizaValorAcao :: [Acao] -> IO [Acao]
atualizaValorAcao acoes = do
  updatedAcoes <- mapM atualizaPreco acoes
  return updatedAcoes
  where
    atualizaPreco acao = do
      preco <- updateValue (preco acao)
      return acao {preco = preco}

    