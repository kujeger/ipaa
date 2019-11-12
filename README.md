# I eller På?

Kjørende instans: https://i.på.io

Denne tjenesten kan fortelle deg om det heter "i" eller "på" et sted.
Den aksepterer både postnummer og poststed!

bruk:

`curl -s https://i.på.io/api/1/steder/postnummer/0651`

`curl -s https://i.på.io/api/1/steder/poststed/OSLO`

(poststed er ikke case-sensitive)

## Oppdatering av liste
Råtata om postnummer er hentet herfra: https://www.bring.no/radgivning/sende-noe/adressetjenester/postnummer/postnummertabeller-veiledning

Legg til/endre preposisjon ved å redigere `postal-name-prepositions.txt`, og så kjøre `updateStedsdata.sh` .

Dette prosjektet finnes takket være Finn.no sin hackdays #5 . Hurrah!

## Å bygge og kjøre
Prosjektet bruker Stack

`stack setup`
`stack build`
`stack run`

## Mangler DITT stedsnavn?
Lag en PR!
