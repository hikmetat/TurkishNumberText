#!/usr/bin/perl6

role TRY {
	multi method Str( --> Str ) {
		return self.Num ~ (callsame) ~ ' TRY'
	}
}

my Int $i = 5 but TRY;

$i.Str.say
