module ValidaCadastro where
import Data.Char
import Data.Maybe
import Data.List.Split (splitOn)

validaNome :: String -> IO()
validaNome nome = do
  if all (all isAlpha) (words nome) && length nome >= 5
    then do
      putStrLn "Nome válido. Prosseguindo o cadastro"
    else do
      putStrLn "Nome inválido.Informe seu nome novamente:"
      novoNome <- getLine
      validaNome novoNome

validaCpf :: String -> IO()
validaCpf cpf = do
  if all isDigit cpf && length cpf == 11
    then do
      putStrLn "CPF válido. Prosseguindo com o cadastro"
    else do
      putStrLn "CPF inválido.Informe seu CPF novamente:"
      novoCpf <- getLine
      validaCpf novoCpf


validaDataNascimento :: String -> IO()
validaDataNascimento dataNascimento = do
  if validaData dataNascimento
    then do
      calculaIdade dataNascimento
    else do
      putStrLn "Data de nascimento inválida. Informe sua data de nascimento novamente:"
      novaDataNascimento <- getLine
      validaDataNascimento novaDataNascimento

validaRenda :: String -> IO()
validaRenda rendaMensal= do
  if all isDigit rendaMensal 
    then do
      putStrLn "Renda válida. Prosseguindo com o cadastro"
    else do
      putStrLn "Renda inválida.Informe sua renda novamente:"
      novaRenda <- getLine
      validaRenda novaRenda


validaPerguntaSecreta :: String -> IO()
validaPerguntaSecreta perguntaSecreta = do
  if not (null perguntaSecreta) || length perguntaSecreta > 13
    then do
      putStrLn "Pergunta válida. Prosseguindo com o cadastro."
    else do
      putStrLn "Pergunta inválida.Informe sua pergunta secreta novamente:"
      novaPerguntaSecreta <- getLine
      validaPerguntaSecreta novaPerguntaSecreta
      
validaRespostaSecreta :: String -> IO()
validaRespostaSecreta respostaSecreta = do
  if not (null respostaSecreta) 
    then do
      putStrLn "Resposta válida. Prosseguindo com o cadastro."
    else do
      putStrLn "Resposta inválida.Informe sua resposta secreta novamente:"
      novaRespostaSecreta <- getLine
      validaRespostaSecreta novaRespostaSecreta

validaSenha :: String -> IO()
validaSenha senha = do
  if not (null senha) && length senha > 8 && all isAscii senha 
    then do 
      putStrLn "Senha válida. Prosseguindo como o cadastro."
    else do
      putStrLn "SenhaInválida. Prosseguindo com o cadastro."
      novaSenha <- getLine
      validaSenha novaSenha

validaData :: String -> Bool
validaData dataNascimento =
  case splitOn "/" dataNascimento  of
    [diaNasc, mesNasc, anoNasc] ->
      let (dia, mes, ano) = (read diaNasc, read mesNasc, read anoNasc)
          diasDeCadaMes = lookup mes [(1,31),(2,28),(3,31),(4,30),(5,31),(6,30),(7,31),(8,31),(9,30),(10,31),(11,30),(12,31)]
          ehAnoBissexto = ano `mod` 4 == 0 && (ano `mod` 100 /= 0 || ano `mod` 400 == 0)
          maximoDeDiasDoMes = case mes of
                      2 | ehAnoBissexto -> 29
                        | otherwise -> 28
                      _ -> fromMaybe 31 diasDeCadaMes
      in dia >= 1 && dia <= maximoDeDiasDoMes
         && mes >= 1 && mes <= 12
         && ano >= 1900 && ano <= 2100
    _ -> False


calculaIdade :: String -> IO ()
calculaIdade dataNascimento = do
  let (dia, mes, ano) = converteData dataNascimento
      (diaRef, mesRef, anoRef) = (10, 2, 2023) -- Data de comparação fixa
      idade = anoRef - ano - if (mesRef, diaRef) < (mes, dia) then 0 else 1
  if idade >= 18
    then putStrLn "Cliente maior de idade. Prosseguindo com o cadastro."
    else putStrLn "Idade menor que 18 anos. Impossível cadastrar." >> return ()
    where
      converteData :: String -> (Int, Int, Int)
      converteData dateStr =
        case splitOn "/" dataNascimento of
          [dataSplit, mesSplit, anoSplit] -> (read dataSplit, read mesSplit, read anoSplit)
          _ -> error "Data inválida"