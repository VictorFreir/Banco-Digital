module investimento.rendimento where
  
import System.Random (randomRIO)


updateMarketStatus :: Int -> Int
updateMarketStatus probability
  | probability == 0 = -1
  | otherwise = 1

updateValue :: Double -> IO Double
updateValue value = do
  probability <- randomRIO (0, 3) -- gera um número aleatório entre 0 e 3
  let factor = if probability == 0 then 0.90 else 1.0 / 0.90 -- determina se o valor será aumentado ou diminuído
  let updatedValue = value * factor -- atualiza o valor
  updateValue