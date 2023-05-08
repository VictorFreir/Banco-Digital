import Control.Concurrent (threadDelay)
import Control.Monad (forever)
import System.Random (randomRIO)
import Data.CSV

updateMarketStatus :: Double -> Double -> Int
updateMarketStatus currentVal lastVal
  | currentVal > lastVal = 1
  | currentVal < lastVal = -1
  | otherwise = 0

updateValue :: Double -> IO Double
updateValue value = do
  probability <- randomRIO (0, 3) -- gera um número aleatório entre 0 e 3
  let factor = if probability == 0 then 0.99 else 1.0 / 0.99 -- determina se o valor será aumentado ou diminuído
  let updatedValue = value * factor -- atualiza o valor
  addToCSV "./acoes.csv" updateValue
  threadDelay 1000000 -- espera um segundo
  updateValue updatedValue -- chama a função novamente com o valor atualizado

addToCSV :: FilePath -> [String] -> IO ()
addToCSV filePath value = do
    let encodedValue = encode [value]
    appendFile filePath encodedValue