module Investimento.Acoes where
import Text.CSV (parseCSVFromFile)
import Investimento.Rendimento
import Data.List.Split (splitOn)

data Acao = Acao { idAcao :: Int, nome :: String, preco :: Double, dividendYeld :: Double } deriving (Eq)

instance Read Acao where
  readsPrec _ str = [(Acao (read idAcao) nome (read preco) (read dividendYeld), "")]
    where
      [idAcao, nome, preco, dividendYeld] = splitOn  "," str

instance Show Acao where
  show (Acao idAcao nome preco dividendYeld) = "Acao " ++ show idAcao ++ " " ++ nome ++ " " ++ show preco ++ " " ++ show dividendYeld
    
-- Função para ler o arquivo CSV e retornar uma lista de Acoes
readAcoes :: String -> IO [Acao]
readAcoes filepath = do
  csvData <- readFile filepath
  let lines = splitOn "\n" csvData
  let a  = map (\l -> read l :: Acao) lines
  return a


atualizaValorAcao :: [Acao] -> IO [Acao]
atualizaValorAcao acoes = do
  updatedAcoes <- mapM atualizaPreco acoes
  return updatedAcoes
  where
    atualizaPreco acao = do
      preco <- updateValue (preco acao)
      return acao {preco = preco}

    
      