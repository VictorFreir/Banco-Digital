dividendos :: Int -> Double -> Double -> Double
dividendos numAcoes precoAcao divYeld = numAcoes * precoAcao * divYeld

main :: IO()
let numAcoes = --pega do usuario
let precoAcao = --pega do csv
let divYeld = --pega do csv
let adicional = dividendos numAcoes precoAcao divYeld
-- tranfere ppro usuario o adicional
