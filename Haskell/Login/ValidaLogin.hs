module Login.ValidaLogin where
  
import Data.Char
import Database.Database
import Models.Conta
import MenuCentral.MenuCentral
  
validaCpfLogin :: String -> IO()
validaCpfLogin cpf = do
  if all isDigit cpf && length cpf == 11
    then do
      if (pegaSenha cpf == "") then
        putStrLn "Cpf não cadastrado" >> return()
      else do
        putStrLn "CPF válido"
    else do
      putStrLn "CPF inválido.Informe seu CPF novamente:"
      novoCpf <- getLine
      validaCpfLogin novoCpf
      
validaSenhaLogin :: String -> String -> IO()
validaSenhaLogin cpf senhaAtual = do
  let conta = pegaContaPeloCPF cpf
  if (senhaAtual == (senha conta))
    then do 
      putStrLn "Login feito com sucesso"
      menuCentral cpf
    else do
      putStrLn "SenhaInválida. Informe sua senha novamente:"
      novaSenha <- getLine
      validaSenhaLogin cpf novaSenha 