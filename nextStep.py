# generate
# .new_pubmed_result.txt
# .new_raw_data.json
# for next step

import json

pmidList = "".join(open("[3]pmidList.txt", 'r').readlines()).split('\n')
pmidList.pop(); #remove last one which is ''
urlOnlyList = [];
for pmid in pmidList:
    _url, title = pmid.split('!!')
    urlOnlyList.append(_url[:-1])

index = 0
length = len(urlOnlyList)
try:
    with open("pubmed_result.txt", "r") as myFormat:
        outputFile = open(".new_pubmed_result.txt", "w")
        while index < length:
            content = myFormat.readline()
            if content == "":
                break
            pmid = urlOnlyList[index].split("/")[-1];
            if len(content) < 17 and pmid == content[6:-1]:
                while content != "\n" and content != "":
                    outputFile.write(content)
                    content = myFormat.readline()
                index = index + 1
                outputFile.write("\n")
        outputFile.close()
except:
    pass
with open("raw_data.json", "r") as myFormat:
    outputFile = open(".new_raw_data.json", "w")
    while index < length:
        jsonString = myFormat.readline()
        if jsonString == "":
            break
        s = json.loads(jsonString)
        url = urlOnlyList[index][5:];
        if str(s['url']) == url:
            outputFile.write(jsonString)
            index = index + 1
    outputFile.close()
