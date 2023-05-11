module RecuperaSenha where

import Text.printf
import Database.Database
  

recuperaSenha :: IO ()
recuperarSenha = do
    putStrLn "Digite seu CPF:"
    cpf <- getLine
    validaCpfLogin cpf
    putStrLn "Responda a sua pergunta secreta:"
    print pegaPerguntaSecreta cpf
    resposta <- getLine
    if ( resposta ==  pegaRespostaSecreta cpf)
        then do
            putStrLn "Resposta secreta correta. Informe a nova senha"
            novaSenha <- getLine
            alteraSenha novaSenha
            putStrLn "Senha alterada com sucesso"
        else do 
            putStrLn "Resposta não confere com a pergunta secreta."