#!/usr/bin/perl -w
require "stemFunction.pl";
# that's the definition. Run initialise() to set things up, then stem($word) to stem $word, as here:

initialise();
$outputfilename = "[2]stemmedSentence.txt";
open($output, '>', $outputfilename);
while (<>) {
    if (/^\n/) {
        print $output "\n";
    }
    if (/^URL/) {
        print $output $_;
        $_ = <>;
    }
    if (/^Title/) {
    	print $output $_;
    	$_ = <>;
    }
    {
        /^([^a-zA-Z]*)(.*)/;
        $_ = $2;
        unless ( /^([a-zA-Z]+)(.*)/ ) { print $output "\n"; last; }
        $word = lc $1; # turn to lower case before calling:
        $_ = $2;
        $stemmedWord = stem($word);
        print $output $stemmedWord. " ";
        print $stemmedWord . ",$word\n";
        redo;
    }
}
1;

# inputs taken from the files on the arg list, output to stdout.

# As an easy speed-up, one might create a hash of word=>stemmed form, and look up each new
# word in the hash, only calling stem() if the word was not found there.
