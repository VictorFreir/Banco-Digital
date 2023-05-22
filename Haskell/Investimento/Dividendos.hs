module Investimento.Dividendos where

dividendos :: Int -> Float -> Float -> Float
dividendos numAcoes precoAcao divYeld = fromIntegral numAcoes * precoAcao * divYeld

