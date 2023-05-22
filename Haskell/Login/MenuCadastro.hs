module Login.MenuCadastro where

import Login.ValidaCadastro
import Models.Conta as Conta
import Models.Emprestimo
import Login.EmprestimoDefault as EmprestimoDefault
--import Login.SalvaConta
import Text.CSV
import Database.Database (criaContaNoCSV)

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
  putStrLn "Informe seu endereco"
  endereco <- getLine
  putStrLn "Informe sua renda mensal"
  rendaMensalStr <- getLine
  validaRenda rendaMensalStr
  putStrLn "Crie uma senha para sua conta"
  senha <- getLine
  putStrLn "Crie uma pergunta secreta para sua conta"
  perguntaSecreta <- getLine
  validaPerguntaSecreta perguntaSecreta
  putStrLn "Crie a resposta da sua pergunta secreta"
  respostaSecreta <- getLine
  validaRespostaSecreta respostaSecreta
  let identificador = sliceID cpf
  let conta = sliceConta cpf
  let saldo = 0.0
  let acoes = [0, 0, 0]
  let emprestimo = emprestimoDefault
  let objConta = Conta identificador nome conta cpf dataNascimento endereco senha perguntaSecreta respostaSecreta saldo acoes emprestimo
  --let lista = [conta]
  criaContaNoCSV objConta
  putStrLn "Cadastro realizado com sucesso"