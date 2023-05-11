-- Saque
-- validacao de saldo e subtracao do total

-- exibeFuncionalidades
-- funcionalidadeID == 2

import Models.Conta as Conta

sacar :: Conta -> IO()
sacar contaAtual = do
    putStrLn "O seu saldo atual e: " ++ show saldo contaAtual
    putStrLn "Informe o valor que deseja sacar: "
    valor <- readLine :: Float
    if (saldo contaAtual > valor) 
    then do
        subtraiValor contaAtual valor
        putStrLn "Saque realizado com sucesso!"
    else do 
        erroValor
        sacar

erroValor :: IO()
erroValor = do
    print "O valor desejado e superior ao valor disponivel em sua conta!"

subtraiValor :: Conta -> Float -> Conta
subtraiValor conta valor = do
    let identificadorConta = (show $ identificador conta)
    let nomeConta = (show $ nome conta)
    let cpfConta = (show $ cpf conta)
    let numeroContaConta = (show $ numeroConta conta)
    let dataNascimentoConta = (show $ dataNascimento conta)
    let enderecoConta = (show $ endereco conta)
    let senhaConta = (show $ senha conta)
    let perguntaSecretaConta = (show $ perguntaSecreta conta)
    let respostaSecretaConta = (show $ respostaSecreta conta)
    let saldoConta = (show $ saldo conta) - valor
    Conta identificadorConta nomeConta cpfConta numeroContaConta dataNascimentoConta enderecoConta senhaConta perguntaSecretaConta respostaSecretaConta saldoConta