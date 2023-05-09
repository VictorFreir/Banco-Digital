module Investimento.Dividendos where

dividendos :: Int -> Double -> Double -> Double
dividendos numAcoes precoAcao divYeld = numAcoes * precoAcao * divYeld

