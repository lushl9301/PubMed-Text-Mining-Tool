pmidList = "".join(open("[3]pmidList.txt", 'r').readlines()).split('\n')
pmidList.pop(); #remove last one which is ''
pmidIDOnlyList = [];
for pmid in pmidList:
    _pmid, title = pmid.split('#')
    pmidIDOnlyList.append(_pmid[:-1])

index = 0
with open("pubmed_result.txt", "r") as myFormat:
	while index < len(pmidIDOnlyList):
		content = myFormat.readline()
		if len(content) < 17 and content[:-1] == pmidIDOnlyList[index]:
			while content != "\n":
				print content[:-1]
				content = myFormat.readline()
			index = index + 1
			print
