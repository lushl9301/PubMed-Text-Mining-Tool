all:
	@echo This may take several minutes.
	@echo Please type the keywords you want in keywords.txt before MAKE.
	@echo ==============================================================
	@echo
	@echo [1] Generate the format used by stem function.
	perl preProcess.pl > [1]myFormat.txt
	@echo ==============================================================
	@echo


	@echo [2] Stem raw sentences. Words are stored in stemDict.txt.
	@echo     Stemmed sentences are stored in stemmedSentence.txt.
	perl stem.pl < [1]myFormat.txt > [2]stemDict.txt
	@echo ==============================================================
	@echo


	@echo [3] Use stemmed keywords to select useful sentences.
	@echo     Results are stored in results.txt
	perl selectSentence.pl
	@echo ==============================================================
	@echo


	@echo [4] Process word frequency analysis.
	@echo     Stop words are eliminated.
	python dict.py > [4]static_words.txt
	@echo ==============================================================
	@echo

	@echo Process done. Please conduct further analysis manually.



clean:
	$(RM) [1]myFormat.txt [2]stemDict.txt [2]stemmedSentence.txt [3]results.txt [4]static_words.txt