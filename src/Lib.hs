{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}
module Lib
    ( startApp
    , app
    ) where

import Data.Aeson
import Data.Aeson.TH
import Network.Wai
import Network.Wai.Handler.Warp
import Servant
import Data.Maybe
import Data.Char
import Sted
import Stedsdata

data Health = Good | Bad

$(deriveJSON defaultOptions ''Kategori)
$(deriveJSON defaultOptions ''Preposisjon)
$(deriveJSON defaultOptions ''Sted)
$(deriveJSON defaultOptions ''Resultat)
$(deriveJSON defaultOptions ''Health)

type StedAPI = Get '[PlainText] String
            :<|> "_" :> "health" :> Get '[JSON] Health
            :<|> "api" :> "1" :> "steder" :> "alle" :> Get '[JSON] [Sted]
            :<|> "api" :> "1" :> "steder" :> "postnummer" :> Capture "x" Postnummer :> Get '[JSON] (Maybe Resultat)
            :<|> "api" :> "1" :> "steder" :> "poststed" :> Capture "x" Poststed :> Get '[JSON] (Maybe Resultat)

startApp :: IO ()
startApp = run 8080 app

app :: Application
app = serve stedAPI server

stedAPI :: Proxy StedAPI
stedAPI = Proxy

server :: Server StedAPI
server = return helpText
      :<|> return Good
      :<|> return steder
      :<|> findPostnummer
      :<|> findPoststed

helpText :: String
helpText = "Bruk:\ncurl /api/1/steder/postnummer/0561\ncurl /api/1/steder/poststed/OSLO\n\n" ++
           "Postnummer-info fra: https://www.bring.no/radgivning/sende-noe/adressetjenester/postnummer/postnummertabeller-veiledning"

findPostnummer :: Int -> Handler (Maybe Resultat)
findPostnummer x = return $ makeResultat $ listToMaybe $ filter ((==) x . fPostnummer) steder

findPoststed :: Poststed -> Handler (Maybe Resultat)
findPoststed x = return $ makeResultat $ listToMaybe $ filter ((==) (map toUpper x) . fPoststed) steder

makeResultat :: Maybe Sted -> Maybe Resultat
makeResultat Nothing = Nothing
makeResultat (Just x) = Just $ Resultat (fPoststed x) (fPreposisjon x)

kategoriBeskrivelse :: Kategori -> String
kategoriBeskrivelse B = "Både gateadresser og postbokser"
kategoriBeskrivelse F = "Flere bruksområder (felles)"
kategoriBeskrivelse G = "Gateadresser (og stedsadresser), dvs. “grønne postkasser”"
kategoriBeskrivelse P = "Postbokser"
kategoriBeskrivelse S = "Servicepostnummer (disse postnumrene er ikke i bruk til postadresser)"
