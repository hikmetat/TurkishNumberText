#!/usr/bin/perl6
unit grammar number;
regex TOP		{ \s* <sign>? 
		          [ 
			    | <characteristic> <decimal-pt> <mantissa>
			    | <characteristic> <decimal-pt>?
			    | <decimal-pt> <mantissa> 
		          ]
		          [ <exponent-indic> <exponent-sign>? <exponent> ]?
			  \s*
			}
token sign 		{ '+' | '-' }
regex characteristic	{ <integer> | <business-int> }
token integer		{ <non-zero-digit> <digit-seq>? | '0' }
token non-zero-digit 	{ <[1..9]> }
token digit-seq		{ <digit>+ }
token business-int	{ <leading-thous> [ <thousands-sep> <trailing-thous> ]* } 
token leading-thous	{ <non-zero-digit> <digit>**0..2 }
token trailing-thous	{ <digit>**3 }
token mantissa		{ <digit-seq> }
token exponent		{ <integer> }
token decimal-pt	{ ',' }
token thousands-sep 	{ '.' }
token exponent-indic	{ 'e' | 'E' }
token exponent-sign	{ '+' | '-' }
