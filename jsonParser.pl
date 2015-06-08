use warnings;
use Lingua::EN::Sentence qw(get_sentences);
use Unicode::Normalize 'normalize';
use JSON;

require "splitFunction.pl";

binmode(STDOUT, ":utf8");

$filename = "raw_data.json";
open FILE, "<:encoding(utf-8)", $filename or exit "can't find file ".$filename;
while ($readinline = <FILE>) {
    if ($readinline =~ /^\n/) {
        next;
    }
    $result = decode_json($readinline);
    $pmid = "PMID- 88888888\n";
    $title = "Title- " . $result->{'title'};
    $abstract = "Abstract- " . $result->{'abstract'};

    if ($title =~ /Title- \[/ or $abstract =~ /^.{7,12}$/) { #if not english or no abstract, ignore
        next;
    }
    ($counter, $abstractSentences) = _split($abstract);
    
    if ($counter > 0) {
        print "$pmid" . "$title\n" . $abstractSentences . "\n";
    }
}
