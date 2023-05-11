module Models.Conta where
  import Models.Emprestimo
  data  Conta  = Conta {
        nome :: String,
        cpf :: String,
        dataNascimento :: String,
        rendaMensal :: String,
        senha :: String,
        perguntaSecreta :: String,
        respostaSecreta :: String,
        saldo :: Int
        -- emprestimo :: Emprestimo
  } deriving (Show)
  






