#!/bin/bash
DATA_ATUAL=$(date +%Y-%m-%d)
mkdir -p ../backups
"/c/Program Files/MySQL/MySQL Server 9.7/bin/mysqldump" -u root -p"" --databases db_pet_vida --routines --triggers > ../backups/petvida_$DATA_ATUAL.sql
