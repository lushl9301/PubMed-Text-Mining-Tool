pmidList = "".join(open("[3]pmidList.txt", 'r').readlines()).split('\n')

head = """<html>
<head>
<title>
PMID List
</title>
</head>
<body>"""
print head
urlHead = '<a href="http://www.ncbi.nlm.nih.gov/pubmed/?term='
urlTail = "</h3></a>"
for pmid in pmidList:
    entry = urlHead + pmid[6:] + '" target="_blank"><h3>' + pmid + urlTail
    print entry

tail = """
</body>
</html>"""
print tail