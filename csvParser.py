import csv
import json
import os

try:
    with open('export.csv') as csvFile:
        jsonFile = open('temp.json', "w")
        csvFile.readline()
        fieldNames = csvFile.readline().replace('\n','').split(',')
        reader = csv.DictReader(csvFile, fieldNames)
        for row in reader:
            jsonFile.write("\n")
            tempDict = {}
            tempDict["url"] = row['PDF Link']
            tempDict["abstract"] = row['"Abstract"']
            tempDict["authors"] = [row['Authors']]
            tempDict["title"] = row['"Document Title"']
            json.dump(tempDict, jsonFile)
except:
    print "Error: only support csv file provided by ieee xplore."
    print "Make sure the file name is export.csv."
    os._exit(0)
jsonFile.close()
jsonFile = open('temp.json', "r")
with open('raw_data.json', "a") as dataFile:
    dataFile.write(jsonFile.read())
