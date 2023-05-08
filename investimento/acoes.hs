module Investimento.Acoes where
import Text.CSV (parseCSVFromFile)

data Acao = Acao { id :: Int, nome :: String, preco :: Double, rendimento :: Double, dividendYeld :: Double }
    
-- Função para converter uma linha de CSV em um objeto Acao
fromCsv :: [String] -> Maybe Acao
fromCsv [i, n, p, r, d] = Just $ Acao (read i) n (read p) (read r) (read d)
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
    