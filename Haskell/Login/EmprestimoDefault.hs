module Login.EmprestimoDefault where

import Models.Emprestimo


emprestimoDefault :: Emprestimo
emprestimoDefault = Emprestimo {
    valorTotal = 0.0,
    proximaParcela = 0.0,
    dataProximaParcela = read "2050-01-01 00:00:00 UTC",
    quantParcelasRestantes = 0,
    taxaJuros = 0.0
}