import Models.People as People

transferir :: People -> People -> Float -> String
transferir contaSaida valor contaChegada = do
    if saldo >= valor then do 
        contaSaida <- subtraiValor contaSaida valor
        contaChegada <- contaChegada #implementar
    else do 
        "erro"

subtraiValor :: People -> Float -> People
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
    People identificadorConta nomeConta cpfConta numeroContaConta dataNascimentoConta enderecoConta senhaConta perguntaSecretaConta respostaSecretaConta saldoConta

