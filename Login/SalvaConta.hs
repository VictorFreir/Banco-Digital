module Login.SalvaConta where

import Text.CSV (parseCSVFromFile)
import Text.Printf (printf)
import Data.List (intercalate)
import System.IO (withFile, IOMode(AppendMode), hSetNewlineMode, universalNewlineMode, hPutStr)
import Models.Conta

escreverCSVConta :: FilePath -> [[String]] -> IO ()
escreverCSVConta nomeArquivo linhas = withFile nomeArquivo AppendMode $ \arquivo -> do
    hSetNewlineMode arquivo universalNewlineMode -- define o modo de nova linha como universal para evitar problemas de compatibilidade
    hPutStr arquivo $ concatMap (intercalate ",") linhas -- concatena as linhas com vírgulas e escreve no arquivo

sairConta :: [Conta] -> IO ()
sairConta conta = do
    let linhas = map (\c -> [nome c, cpf c, dataNascimento c, senha c, perguntaSecreta c, respostaSecreta c, printf "%.2f" (saldo c), "\n"]) conta
    escreverCSVConta "./contas.csv" linhas
