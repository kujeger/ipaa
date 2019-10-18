#!/bin/bash

dos2unix < Postnummerregister-ansi.txt | iconv -f MS-ANSI -t UTF-8 > Postnummerregister-utf8.txt
