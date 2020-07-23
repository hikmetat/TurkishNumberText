#!/usr/bin/perl6

use MONKEY;
use Test;
use lib '.';
use number;

=comment
FNC- SET-NAME-------------------------- V1------ V2------- V3-------- V4------ V5----- V6----------- V7--------------- V8--------------- 

my $test-data = '
ok  |zero and pos ints                 |0       |1        |10        |16      |99     |100          |1009             |345678
ok  |neg ints                          |-1      |-76      |-139003   |        |       |             |                 |
ok  |ints with trailing decimal pt     |0,      |102,     |-90456,   |        |       |             |                 |
ok  |with whole and decimal compts     |0,0     |0,102    |0,03      |-0,0    |-0,9   |19,9046      |199,0489         |-7988,002
ok  |with leading decimal points       |,0      |-,0      |,009      |,19080  |-,6    |-,004        |                 |
ok  |business integers                 |1.000   |22.980   |767.766   |        |       |2.000.000    |93.768.222       |-900.000.000.001
ok  |b-ints with decimal compts+pt     |1.000,  |22.980,0 |-22.092,  |        |       |             |767.766,009      |-900.000.000,001
ok  |integers with exponents           |0e0     |0e1      |10E23     |10e-9   |-34e3  |-44E-4       |0,e11            |,19E-9
ok  |decimal parts with exponents      |,0e12   |-,0E-1   |,10e-9    |-,005E2 |       |             |                 |
ok  |with whole, dec and exp parts     |0,0e4   |-0,0E-2  |          |        |       |             |8976444,007e-98  |-90089,002034E19
ok  |b-ints with dec and exponent      |        |         |          |        |       |100.000,1e-9 |-98.907.111E44   |100.000.000,01E-8 
nok |zero and positive integers        |00      |01       |x10       |4a4     |hex    |             |                 |
nok |negative integers                 |-00     |-076     |-13a      |        |       |             |                 |
nok |integers with trailing dec pts    |00,     |-x102,   |06,       |        |       |             |                 |
nok |nums with whole and dec compts    |00,0    |001,102  |0,03,1    |        |       |             |                 |
nok |decimals with leading dec pts     |,0x     |-,x      |          |        |       |             |                 |
nok |business integers                 |900.00  |22.      |767.7     |000.333 |       |2222.000.000 | -93.768.222.0   |-900.000.000.00x
nok |b-ints with trailing dec cmpts+pt |1.0000, |2-.092,  |-900.,001 |        |       |000.123,45   |2.766,009.1      |8.980,090.889
nok |integers with exponents           |e0      |,4e1,4   |10e-9,3   |        |       |10E23.000    |                 |
nok |decimal parts with exponents      |,0e12,4 |,3e-     |,0E-1.008 |        |       |             |                 |
nok |with whole and dec compts+expts   |0,0x4   |         |          |        |       |-0,0E-2,2    |8944,087e-987.009|-90089,002304E1,9
nok |b-ints with dec and exponent      |100.e9  |         |          |        |       |100.000,1-e9 |98,907.111E44    |000.770.200,01E-8 
';

for $test-data.split( "\n" ).map( *.trim  ).grep( { / \S / } ) {
	my ( $sub-name, $class-name, @test-values )  = .split( / \s*\| / );
	my $test-sub = EVAL "&$sub-name";
	say "--- '$sub-name' tests: $class-name ---";
	$test-sub( number.parse( $_ ), $_ ) for @test-values.grep( { / \S / } );
}
done-testing;
