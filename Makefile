.PHONY: clean .myFormat .stem .result .statistic all

.myFormat: preProcess.pl pubmed_result.txt
	@echo This may take several minutes.
	@echo Please type the keywords you want in keywords.txt before MAKE.
	@echo ==============================================================
	@echo
	@echo [1] Generate the format used by stem function.
	@rm -f [1]myFormat.txt
	@touch [1]myFormat.txt
	python csvParser.py
	#mv csv file in case make next
	@mv export.csv export.csv.b
	perl preProcess.pl >> [1]myFormat.txt
	perl jsonParser.pl >> [1]myFormat.txt
	@echo ==============================================================
	@echo

.stem: .myFormat stem.pl [1]myFormat.txt
	@echo [2] Stem raw sentences. Words are stored in stemDict.txt.
	@echo     Stemmed sentences are stored in stemmedSentence.txt.
	perl stem.pl < [1]myFormat.txt > [2]stemDict.txt
	@echo ==============================================================
	@echo

.result: .stem selectSentence.pl [2]stemmedSentence.txt
	@echo [3] Use stemmed keywords to select useful sentences.
	@echo     Results are stored in results.txt
	@echo     PMID are listed in pmidList.txt
	perl selectSentence.pl
	@echo ==============================================================
	@echo

.statistic: .stem dict.py [2]stemDict.txt
	@echo [4] Process word frequency analysis.
	@echo     Stop words are eliminated.
	python dict.py > [4]static_words.txt
	@echo ==============================================================
	@echo

all: .result .statistic
	@echo Process done. Please conduct further analysis manually.
	@echo You can generate PMID HTML list by typing \"make html\".
	@echo ==============================================================
	@echo
	@echo Or, conduct next step analysis by typing \"make next\".
	@echo New pubmed_result.txt will be generated.
	@echo Current raw data and keywords will be moved into ./backup/
	@echo ==============================================================
	@echo


html:
	@echo [*]Use generated PMID list for creating an html file for easy access.
	python htmlGenerator.py > PMIDList.html


next:
	@echo New pubmed_result.txt is generated based on given keyword\(s\).
	python nextStep.py
	$(eval TIMESTAMP = $(shell date +%Y%m%d%H%M%S))
	@mkdir -p backup
	@mv pubmed_result.txt backup/pubmed_result.txt.${TIMESTAMP}
	@mv raw_data.json backup/raw_data.json.${TIMESTAMP}
	@cp keywords.txt backup/keywords.txt.${TIMESTAMP}
	cp .new_pubmed_result.txt pubmed_result.txt
	cp .new_raw_data.json raw_data.json

clean:
	@$(RM) [1]myFormat.txt [2]stemDict.txt [2]stemmedSentence.txt [3]results.txt [3]pmidList.txt [4]static_words.txt
	@$(RM) PMIDList.html