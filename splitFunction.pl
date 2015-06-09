#!/usr/bin/perl -w
sub _split {
    my $tempAbstract = $_[0];
    chomp($tempAbstract);
    my $splitted = get_sentences($tempAbstract);
    my $abstractSentences = join("\n", @$splitted) . "\n";
    my $counter = @$splitted;
    return ($counter, $abstractSentences)
}

#return true
1;