#!/usr/bin/raku

unit role Lingua::TR::Numbers:ver<0.0.1>;

use lib '.';
#use number;

unit role TurkishText;

our %ones = 
	1 => 'bir', 2 => 'iki', 3 => 'üç', 4 => 'dört', 5 => 'beş', 6 => 'altı', 7 => 'yedi', 8 => 'sekiz', 9 => 'dokuz';
our %tens =
	10 => 'on', 20 => 'yirmi', 30 => 'otuz', 40 => 'kırk', 50 => 'elli', 
	60 => 'altmış', 70 => 'yetmiş', 80 => 'seksen', 90 => 'doksan';

method words() { 
	if self.defined {
		if self ~~ Num {
			return self!num2tr( self.Num )
		} else {
			#if number.parse(self.Str) {
			#	return 	self!num2tr( self.Num ) 
			#} else {
			#	return ''
			#}
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


=begin pod

=head1 NAME

Lingua::TR::Numbers - A raku module for converting numbers to Turkish text

=head1 SYNOPSIS

=begin code :lang<raku>

use Lingua::TR::Numbers;

=end code

=head1 DESCRIPTION

Lingua::TR::Numbers is a raku module to convert a number such as 597 into Turkish text.

The module understands a variety of number formats for numbers with a whole and/or fractional part.

The naming of the module and some of its functions follow the conventions of the perl Lingua::EN::Numbers module by Neil Bowers.

=head1 AUTHOR

Hikmet Arif Topcuoglu <hikmet.arif.topcuoglu@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2020 Hikmet Arif Topcuoglu

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
