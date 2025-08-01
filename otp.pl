#!/usr/bin/perl

use strict;
use warnings;

# Ask if output should be saved to a file
print "Do you want to save the output to a file? (y/n): ";
my $save_to_file = <STDIN>;
chomp($save_to_file);

my $file_handle;
if ($save_to_file eq 'y') {
    # Prompt for the file name
    print "Enter the filename: ";
    my $filename = <STDIN>;
    chomp($filename);

    # Open the file for writing
    open($file_handle, '>', $filename) or die "Could not open file '$filename' $!";
    print "Output will be saved to '$filename'.\n";
}

# Get user input for how many PADs to generate
my $choice = "y";
chomp($choice);

if ($choice ne 'n') {
    print "Number of pads? ";
    my $thismany = <STDIN>;
    chomp($thismany);
    $thismany = int($thismany);  # Convert to an integer

    # Default to 1 PAD if the input is 0 or invalid
    $thismany = 1 if $thismany <= 0;

    for my $n (1..$thismany) {
        my $pad_output = "\nPAD [$n]\n\n";

        # Generate a 11x5 grid of random numbers
        for my $k (1..11) {
            for my $y (1..5) {
                for my $i (1..5) {
                    $pad_output .= int(rand(9)) + 1;  # Generate random number 1-9
                }
                $pad_output .= " ";  # Space between blocks
            }
            $pad_output .= "\n";  # New line after each row
        }
        $pad_output .= "\n";  # Extra space after each PAD

        # Output to console and file (if selected)
        print $pad_output;
        if ($save_to_file eq 'y') {
            print $file_handle $pad_output;
        }
    }
}

# Close the file if it was opened
if ($save_to_file eq 'y') {
    close $file_handle;
    print "Output successfully saved to file.\n";
}
