module MenuCadastro where
import ValidaCadastro
import Models.Conta
import Models.Emprestimo
import EmprestimoDefault

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
  putStrLn "Crie uma senha para sua conta"
  senha <- getLine
  validaSenha senha
  putStrLn "Crie uma pergunta secreta para sua conta"
  perguntaSecreta <- getLine
  validaPerguntaSecreta perguntaSecreta
  putStrLn "Crie a resposta da sua pergunta secreta"
  respostaSecreta <- getLine
  validaRespostaSecreta respostaSecreta
  let emprestimo = emprestimoDefault
  let cliente = Cliente nome cpf dataNascimento rendaMensalStr senha perguntaSecreta respostaSecreta emprestimo
  --adicionar a aonta ao bd
  putStrLn "Cadastro realizado com sucesso"

