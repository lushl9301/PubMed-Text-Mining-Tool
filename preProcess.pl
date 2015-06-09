use warnings;
use Lingua::EN::Sentence qw(get_sentences);
use Unicode::Normalize 'normalize';

require "splitFunction.pl";

binmode(STDOUT, ":utf8");

$filename = "pubmed_result.txt";
open FILE, "<:encoding(utf-8)", $filename or exit "can't find file ".$filename;
while ($readinline = <FILE>) {
    if ($readinline =~ /^\n/) {
        next;
    }
    $pmid = "URL- http://www.ncbi.nlm.nih.gov/pubmed/";
    $title = "Title- ";
    $abstract = "Abstract- ";

    #PMID
    $readinline =~ /(\d+)\n/;
    $pmid .= $1 . "\n";


    while ($readinline = <FILE>) {
        if ($readinline =~ /^\n/) {
            last; #finish one file, break, do another
        }

        #title
        if ($readinline =~ /TI\s+-/) {
            $readinline =~ s/^TI\s+-//g; #remove TI  -
            $readinline =~ s/^\s+|\s+$//g; #remove leading/trailing spaces
            $title .= $readinline;
            while ($readinline = <FILE>) {
                if ($readinline =~ /^\s/) {
                    $readinline =~ s/^\s+|\s+$//g;
                    $title .= (" ".$readinline);
                } else {
                    last;
                }
            }
        }

        #abstract
        if ($readinline =~ /AB\s+-/) {
            $readinline =~ s/^AB\s+-//g; #remove AB  -
            $readinline =~ s/^\s+|\s+$//g; #remove leading/trailing spaces
            $abstract .= $readinline;
            while ($readinline = <FILE>) {
                if ($readinline =~ /^\s/) {
                    $readinline =~ s/^\s+|\s+$//g;
                    $abstract .= (" ".$readinline);
                } else {
                    last;
                }
            }
        }
    }

    if ($title =~ /Title- \[/ or $abstract =~ /^.{7,12}$/) { #if not english or no abstract, ignore
        next;
    }
    
    ($counter, $abstractSentences) = _split($abstract);

    if ($counter > 0) {
        print "$pmid" . "$title\n" . $abstractSentences . "\n";
    }
}
