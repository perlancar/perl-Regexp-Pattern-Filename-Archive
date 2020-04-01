package Regexp::Pattern::Filename::Archive;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;
#use utf8;

use Filename::Archive ();
use Filename::Compressed ();

our %RE;

my $re = join('',
              '(?:', join('|', map {quotemeta} sort keys %Filename::Archive::SUFFIXES   ), ')',
              '(?:', join('|', map {quotemeta} sort keys %Filename::Compressed::SUFFIXES), ')*',
          );
$re = qr($re\z)i;

$RE{filename_archive} = {
    summary => 'Archive filename',
    pat => $re,
    tags => ['anchored'],
    examples => [
        {str=>'foo', matches=>0, summary=>'No extension'},
        {str=>'zip', matches=>0, summary=>'Not an extension'},
        {str=>'foo.zip', matches=>1},
        {str=>'foo.tar.gz', matches=>1, summary=>'Plus compression'},
        {str=>'foo bar.TBZ', matches=>1, summary=>'Case insensitive'},
        {str=>'foo.ARJ is the file', matches=>0, summary=>'Regex is anchored'},
        {str=>'foo.txt', matches=>0},
    ],
};

1;
# ABSTRACT: Archive filename

=head1 DESCRIPTION

This is a L<Regexp::Pattern> wrapper for L<Filename::Archive>.


=head1 SEE ALSO

L<Regexp::Pattern>

L<Filename::Archive>
