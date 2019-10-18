module Sted where

type Postnummer = Int
type Poststed = String
type Kommunekode = Int
type Kommunenavn = String
data Kategori = B | F | G | P | S
            deriving (Eq, Show)

data Preposisjon = På | I | Ukjent
            deriving (Eq, Show)
            
data Sted = Sted {
    fPostnummer  :: Postnummer,
    fPoststed    :: Poststed,
    fKommunekode :: Kommunekode,
    fKommunenavn :: Kommunenavn,
    fKategori    :: Kategori,
    fPreposisjon :: Preposisjon
} deriving (Eq, Show)

data Resultat = Resultat {
    poststed :: Poststed,
    preposisjon :: Preposisjon
} deriving (Eq, Show)
