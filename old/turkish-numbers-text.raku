#!/usr/bin/perl6

use lib '.';
use number;

our %ones = 
	1 => 'bir', 2 => 'iki', 3 => 'üç', 4 => 'dört', 5 => 'beş', 6 => 'altı', 7 => 'yedi', 8 => 'sekiz', 9 => 'dokuz';
our %tens =
	10 => 'on', 20 => 'yirmi', 30 => 'otuz', 40 => 'kırk', 50 => 'elli', 
	60 => 'altmış', 70 => 'yetmiş', 80 => 'seksen', 90 => 'doksan';
# number.parse($_)

sub get-test-data( IO:D $file where *.e --> Hash ) {
	$file.lines.map( *.subst(/ \#.* /, '') ).grep( { /\S/ } ).map( { 
		my ( $num, @words ) = .split( /\s+/ ); 
		$num, @words.join(' ')
	} ).flat.Hash
}

my %tests = get-test-data( 'test-data.txt'.IO );
#say %tests;exit;
%tests.keys.sort(+*).map( {
	my $num = +$_; 
	my Str $expected = %tests{$num}; 
	my Str $result = num2tr($num).join(' ');
	if $result eq $expected {
		sprintf( "%20d OK: $result", $num)
	} else {
		sprintf( "%20d NOT OK -- Expected: %-50s Got: %-50s", $num, $expected, $result)
	}
} ).join("\n").say;

multi sub num2tr( 0 --> Iterable ) { return @( 'sıfır' ) }

multi sub num2tr( Int:D $num where 0 < * <= 9 --> Iterable ) { return %ones{$num}.List }

multi sub num2tr( Int:D $num where { 10 <= $num <= 99 } --> Iterable ) {
	my Int $rmdr = $num % 10;
	my @result = %tens{ $num - $rmdr };
	return @result.append( num2tr( $rmdr ) )
}

multi sub num2tr( Int:D $num where { 100 <= $num <= 999 } --> Iterable) {
	my Int $rmdr = $num % 100;
	my Int $hundred = $num div 100;
	my @result = <yüz>, ;
	@result.prepend( num2tr($hundred) ) if $hundred > 1;
	@result.append( num2tr($rmdr) ) if $rmdr > 0;
	return @result
}

multi sub num2tr( Int:D $num --> List ) {
	<under development>.List
}
