#!/usr/bin/perl6

use Test;
use Lingua::TR::Numbers;

sub get-test-data( IO:D $file where *.e --> Hash ) {
	$file.lines.map( *.subst(/ \#.* /, '') ).grep( { /\S/ } ).map( { 
		my ( $num, @words ) = .split( /\s+/ ); 
		$num, @words.join(' ')
	} ).flat.Hash
}

my %tests = get-test-data( 'TR-Number-TestData.txt'.IO );

plan %tests.keys.elems;

for %tests.keys.sort(+*) {
	my $num = +$_; 
	my Str $expected = %tests{$num}; 
	my Str $result = num2tr($num).join(' ');
	ok $result eq $expected, "$result resulted against expectation: $expected"; 
}

done-testing;
