words = "".join(open("[2]stemDict.txt", 'r').readlines()).split('\n')
stop_words = ["a", "about", "above", "after", "again", "against", "all", "am", "an", "and", "any", "are", "aren't", "as", "at", "be", "because", "been", "before", "being", "below", "between", "both", "but", "by", "can't", "cannot", "could", "couldn't", "did", "didn't", "do", "does", "doesn't", "doing", "don't", "down", "during", "each", "few", "for", "from", "further", "had", "hadn't", "has", "hasn't", "have", "haven't", "having", "he", "he'd", "he'll", "he's", "her", "here", "here's", "hers", "herself", "him", "himself", "his", "how", "how's", "i", "i'd", "i'll", "i'm", "i've", "if", "in", "into", "is", "isn't", "it", "it's", "its", "itself", "let's", "me", "more", "most", "mustn't", "my", "myself", "no", "nor", "not", "of", "off", "on", "once", "only", "or", "other", "ought", "our", "ours", "ourselves", "out", "over", "own", "same", "shan't", "she", "she'd", "she'll", "she's", "should", "shouldn't", "so", "some", "such", "than", "that", "that's", "the", "their", "theirs", "them", "themselves", "then", "there", "there's", "these", "they", "they'd", "they'll", "they're", "they've", "this", "those", "through", "to", "too", "under", "until", "up", "very", "was", "wasn't", "we", "we'd", "we'll", "we're", "we've", "were", "weren't", "what", "what's", "when", "when's", "where", "where's", "which", "while", "who", "who's", "whom", "why", "why's", "with", "won't", "would", "wouldn't", "you", "you'd", "you'll", "you're", "you've", "your", "yours", "yourself", "yourselves"]
dic = {}
for x in words:
    word_tuple = x.split(",")
    try:
        stemmed_word, original_word = word_tuple[0], word_tuple[1]
    except:
        continue
    if stemmed_word in stop_words or original_word in stop_words:
        continue;
    if stemmed_word in dic:
        dic[stemmed_word][0] += 1
        if not original_word in dic[stemmed_word]:
            dic[stemmed_word].append(original_word);
    else:
        dic[stemmed_word] = [1, original_word];
import operator
sorted_words = sorted(dic.iteritems(), key=operator.itemgetter(1), reverse=True)
for tu in sorted_words:
    print tu[0] + " " + str(tu[1].pop(0)) + " " + str(tu[1])