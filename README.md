# I eller På?

Denne tjenesten kan fortelle deg om det heter "i" eller "på" et sted.
Den aksepterer både postnummer og poststed!

bruk:
curl -s localhost:8080/api/1/steder/postnummer/0651
curl -s localhost:8080/api/1/steder/poststed/OSLO

(poststed er ikke case-sensitive)

## Oppdatering av liste
Råtata om postnummer er hentet herfra: https://www.bring.no/radgivning/sende-noe/adressetjenester/postnummer/postnummertabeller-veiledning

For å generere endelig dataliste til Stedsdata.hs kan du kjøre `updateStedsdata.sh`

Dette prosjektet finnes takket være Finn.no sin hackdays #5 . Hurrah!
