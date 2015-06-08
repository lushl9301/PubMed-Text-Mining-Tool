#!/usr/bin/perl -w
sub _split {
    my $tempAbstract = $_[0];
    chomp($tempAbstract);
    my $splitted = get_sentences($tempAbstract);
    my $abstractSentences = join("\n", @$splitted);
    my $counter = @$splitted;
    return ($counter, $abstractSentences)
}

#return true
1;