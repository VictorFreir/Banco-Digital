module Login.RecuperaSenha where

import Text.Printf
import Database.Database
import Login.ValidaLogin
  

recuperaSenha :: IO ()
recuperaSenha = do
    putStrLn "Digite seu CPF:"
    cpf <- getLine
    validaCpfLogin cpf
    putStrLn "Responda a sua pergunta secreta:"
    print (pegaPerguntaSecreta cpf)
    resposta <- getLine
    if ( resposta ==  pegaRespostaSecreta cpf)
        then do
            putStrLn "Resposta secreta correta. Informe a nova senha"
            novaSenha <- getLine
            alteraSenha cpf novaSenha
            putStrLn "Senha alterada com sucesso"
        else do 
            putStrLn "Resposta não confere com a pergunta secreta."