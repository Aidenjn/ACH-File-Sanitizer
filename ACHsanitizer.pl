#Author: Aiden Nelson
#Date: 7/5/2018
#Description:
#Full ACH file sanitizer.

use strict;
use warnings;

# Setup input and output
open(my $inputFile, "<", @ARGV) or die "Can't open ", @ARGV, ": $!";	# Open file given as argument
open(my $outputFile, ">", "sanitized_file.dat") or die "Can't create sanitized_file: $!";

# Main loop
while (<$inputFile>) {	# Assigns next line to $_ each iteration
	my @lineChars = split("", $_);
	if ($lineChars[0] == 6) {	# Line with a card number.
		for (my $i = 18; $i <= 25; $i++) {	# Zero out numbers
			$lineChars[$i] = 0;
		}
		for (my $i = 40; $i <= 78; $i++) {
			$lineChars[$i] = charRandomizer($lineChars[$i]);
		}
	}
	elsif ($lineChars[0] == 5) {	# Header line.
		for (my $i = 53; $i <= 69; $i++) {
			$lineChars[$i] = charRandomizer($lineChars[$i]);
		}
	}
	print $outputFile @lineChars;
}

close $outputFile;


######   SUBROUTINES   ######

# Function: charCheck
# Description: Checks that the given character is a capital or lowercase letter.
# Parameters: Character being input.
# Pre-Conditions: None
# Post-Conditions: Output must be 0, 1, or 2.
# Return: 0 - Not a letter, 1 - Lowercase letter, 2 - Uppercase letter.
sub charCheck {
	my $char = ord(shift);
	if (97 <= $char && $char <= 122) {
		return 1;
	}
	elsif (65 <= $char && $char <= 90) {
		return 2;
	}
	return 0;
}

# Function: charRandomizer
# Description: Returns a random lowercase or uppercase character.
# Parameters: Character being input.
# Pre-Conditions: None
# Post-Conditions: Type 1 - Random lowercase, 2 - Random uppercase, 0 - No change.
# Return: Processed character.
sub charRandomizer {
	my $char = shift;
	my $decision = charCheck($char);
	if ($decision == 1) {	# Lowercase
		$char = (chr(randomReturn(97, 122)));
	}
	elsif ($decision == 2) {	# Uppercase
		$char = (chr(randomReturn(65, 90)));
	}
	return $char;
}

# Function: randomReturn
# Description: Returns a random number within a specified range.
# Parameters: Lower bound, Upper bound.
# Pre-Conditions: Parameters are integers.
# Post-Conditions: Return integer is within range specified.
# Return: Random number.
sub randomReturn {
	my $lowerLimit = $_[0];
	my $upperLimit = $_[1];
	return (int(rand($upperLimit - $lowerLimit)) + $lowerLimit);
}