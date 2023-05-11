module MenuCadastro where
import ValidaCadastro
import Models.Conta
import Models.Emprestimo
import EmprestimoDefault
import SalvaConta
import Text.CSV

cadastrarCliente :: IO()
cadastrarCliente = do
  putStrLn "Iniciando cadastro"
  putStrLn "Informe seu nome"
  nome <- getLine
  validaNome nome
  putStrLn "Informe seu CPF no formato 00000000000"
  cpf <- getLine
  validaCpf cpf
  putStrLn "Informe sua data de nascimento no formato dd/mm/aaaa"
  dataNascimento <- getLine
  validaDataNascimento dataNascimento
  putStrLn "Informe sua renda mensal"
  rendaMensalStr <- getLine
  validaRenda rendaMensalStr
  putStrLn "Crie uma senha para sua conta (No Minimo 8 digitos)"
  senha <- getLine
  validaSenha senha
  putStrLn "Crie uma pergunta secreta para sua conta"
  perguntaSecreta <- getLine
  validaPerguntaSecreta perguntaSecreta
  putStrLn "Crie a resposta da sua pergunta secreta"
  respostaSecreta <- getLine
  validaRespostaSecreta respostaSecreta
  let saldo = 0.0
  -- let emprestimo = emprestimoDefault
  let conta = Conta nome cpf dataNascimento rendaMensalStr senha perguntaSecreta respostaSecreta saldo --emprestimo
  let lista = [conta]
  sairConta lista
  putStrLn "Cadastro realizado com sucesso"
