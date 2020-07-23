#!/usr/bin/perl6

use lib '.';
use number;

unit role TurkishText;

has Str $.number Where number.parse(*) = '0';

method Text() { 
	if self.defined {
		if self ~~ Num {
			return self!num2tr( self.Num )
		} else {
			if number.parse(self.Str) {
				return 	self!num2tr( self.Num ) 
			} else {
				return ''
			}
		}
	} else { 
		return '' 
	} 
}
multi !method num2tr( 0 --> Iterable ) { return @( 'sıfır' ) }

multi !method num2tr( Int:D $num where 0 < * <= 9 --> Iterable ) { return %ones{ $num }.List }

multi !method num2tr( Int:D $num where { 10 <= $num <= 99 } --> Iterable ) {
	my Int $rmdr = $num % 10;
	my @result = %tens{ $num - $rmdr };
	return @result.append( self!num2tr( $rmdr ) )
}

multi !method num2tr( Int:D $num where { 100 <= $num <= 999 } --> Iterable) {
	my Int $rmdr = $num % 100;
	my Int $hundred = $num div 100;
	my @result = <yüz>, ;
	@result.prepend( self!num2tr($hundred) ) if $hundred > 1;
	@result.append(  self!num2tr($rmdr)    ) if $rmdr > 0;
	return @result
}

multi !method num2tr( Numeric:D $num --> List ) {
	<under development>.List
}
