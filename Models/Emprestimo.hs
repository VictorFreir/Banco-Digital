module Models.Emprestimo where
import GHC.Generics
import Data.Time (UTCTime)


data Emprestimo = Emprestimo {
    valorTotal :: Float,
    proximaParcela :: Float,
    dataProximaParcela :: UTCTime,
    quantParcelasRestantes :: Float,
    taxaJuros :: Float
  } deriving (Show, Generic)