module Models.Conta where
  import Models.Emprestimo
  data Cliente  = Cliente {
        nome :: String,
        cpf :: String,
        dataNascimento :: String,
        rendaMensal :: String,
        senha :: String,
        perguntaSecreta :: String,
        respostaSecreta :: String,
        emprestimo :: Emprestimo
  } deriving (Show)
  






