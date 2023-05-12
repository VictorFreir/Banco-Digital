module Login.ValidaLogin where
  
import Data.Char
import Database.Database
  
validaCpfLogin :: String -> IO()
validaCpfLogin cpf = do
  if all isDigit cpf && length cpf == 11
    then do
      if (pegaSenha cpf == 0) then
        putStrLn "Cpf não cadastrado" >> return()
      else do
        putStrLn "CPF válido"
    else do
      putStrLn "CPF inválido.Informe seu CPF novamente:"
      novoCpf <- getLine
      validaCpfLogin novoCpf
      
validaSenhaLogin :: String -> IO()
validaSenhaLogin senha = do
  if (senha == pegaSenha cpf)
    then do 
      putStrLn "Login feito com sucesso"
      >> menuCentral
    else do
      putStrLn "SenhaInválida. Informe sua senha novamente:"
      novaSenha <- getLine
      validaSenha novaSenha