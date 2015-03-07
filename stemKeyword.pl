#stem keywords
use warnings;
require "stemFunction.pl";

initialise();
our @keywords = (); #shared keywords
$filename = "keywords.txt";
open FILE, "<:encoding(utf-8)", $filename or die "can't find file ".$filename;
while (<FILE>) {
    if (/^\n/ or /^\#/) {
    	next;
    }
    chomp($_); #cannot been searched if you don't chomp it
    $word = lc $_; # turn to lower case before calling:
    $stemmedWord = stem($word);
    push @keywords, $stemmedWord;
}
1;