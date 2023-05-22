# DigiBank

## Como executar o projeto:

### Pré-requisitos:

- [ghc](https://www.haskell.org/ghc/)
- [cabal](https://www.haskell.org/cabal/)

### Rodando o projeto:

1. Clone o repositório
    ```git clone https://github.com/VictorFreir/Banco-Digital.git``` 
2. Entre na pasta do projeto
   ```cd /path/para/o/Banco-Digital```
   <small>Obs: subtitua o trecho '`/path/para/o/Banco-Digital`' pelo diretório para qual o projeto foi clonado</small>
3. Execute esse comando para instalar as dependências
    ``` 
        cabal install \
        base \
        bytestring\
        cassava\
        data-array-byte\
        directory\
        parsec\
        process \
        random \
        split \
        splitmix \
        text \
        time 
    ```
4. Execute o comando
   ```ghc ./app/Main.hs```
5. Agora é só rodar binário do projeto com:
   ```./app/main```