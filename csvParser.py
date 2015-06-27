import csv
import json


jsonFile = open("raw_data.json", "a")
jsonFile.write("\n")
with open('export.csv') as csvFile:
    csvFile.readline()
    fieldNames = csvFile.readline().replace('\n','').split(',')
    reader = csv.DictReader(csvFile, fieldNames)
    for row in reader:
        tempDict = {}
        tempDict["url"] = row['PDF Link']
        tempDict["abstract"] = row['"Abstract"']
        tempDict["authors"] = [row['Authors']]
        tempDict["title"] = row['"Document Title"']
        json.dump(tempDict, jsonFile)
        jsonFile.write("\n")
