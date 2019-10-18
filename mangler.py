#!/usr/bin/env python3

import csv
import pprint

def main():
    register = []
    prepositions = {}
    with open('postal-name-prepositions.txt', 'r') as prepositionfile:
        prepositionreader = csv.reader(prepositionfile, delimiter='=')
        for row in prepositionreader:
            if len(row) >= 2:
                prepositions[row[0]] = row[1].capitalize()
    with open('Postnummerregister-utf8.txt', 'r') as registerfile:
        registerreader = csv.reader(registerfile, delimiter='\t')
        for row in registerreader:
            prep = prepositions.get(row[1], "Ukjent")
            register.append({
                'postnummer': row[0],
                'poststed': row[1],
                'kommunekode': row[2],
                'kommunenavn': row[3],
                'kategori': row[4],
                'preposisjon': prep,
                })

    print("module Stedsdata where\n\nimport Sted\n\nsteder :: [Sted]\nsteder = [")
    outputlines = []
    for s in register:
        text = "    Sted {postnummer} \"{poststed}\" {kommunekode} \"{kommunenavn}\" {kategori} {preposisjon},".format(
            postnummer=s['postnummer'],
            poststed=s['poststed'],
            kommunekode=s['kommunekode'],
            kommunenavn=s['kommunenavn'],
            kategori=s['kategori'],
            preposisjon=s['preposisjon'],
            )
        outputlines.append(text)
    outputlines[-1] = outputlines[-1][:-1]
    for i in outputlines:
        print(i)
    print("    ]")

#    pprint.pprint(prepositions)    


if __name__ == '__main__':
    main()
