use warnings;
use Lingua::EN::Sentence qw(get_sentences);
use File::Copy;
require "stemKeyword.pl";
our @keywords; #shared keywords

if (scalar @keywords == 0) {
    print "Since no keywords are specified, original results will be shown instead.\n";
    copy('[1]myFormat.txt', '[3]results.txt') or die "Failed to use original results\n";
    exit 0;
}

binmode(STDOUT, ":utf8");

$filename = "[2]stemmedSentence.txt";
open FILE, "<:encoding(utf-8)", $filename or die "can't find file ".$filename;

open ($output, '>', "[3]results.txt");

while ($readinline = <FILE>) {
    if ($readinline =~ /^\n/) {
        next;
    }
    $PMID = $readinline;
    $useful = "";
    $numOfSen = 0;
    while ($readinline = <FILE>) {
        if ($readinline =~ /^\n/) {
            last; #finish abstact; break
        }
        $counter = 0;
        foreach $keyword (@keywords) {
            if ($readinline =~ /$keyword/i) {
                $counter += 1;
            }
        }
        if ($counter >= scalar @keywords) {
            $useful .= $readinline;
            $numOfSen += 1;
        }
    }
    if ($numOfSen > 0) {
        print $output "$PMID" . $useful . "\n";
    }
}
close $output or die "can't close file";