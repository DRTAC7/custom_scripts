#!/usr/bin/perl
use strict;
use warnings;
use POSIX qw(floor);

# DTMF frequency rows (low freq)
my @low_freqs = (697, 770, 852, 941);
# DTMF frequency cols (high freq)
my @high_freqs = (1209, 1336, 1477, 1633);

# Corresponding DTMF characters by row,col
my @dtmf_table = (
    ['1','2','3','A'],
    ['4','5','6','B'],
    ['7','8','9','C'],
    ['*','0','#','D'],
);

sub hex_to_float {
    my ($hex) = @_;
    # Convert hex string to packed binary, then unpack as float
    # Remove leading '0x' if present
    $hex =~ s/^0x//;
    my $packed = pack("H8", $hex);
    return unpack("f>", $packed);  # Big-endian float
}

sub closest_freq_index {
    my ($freq, $freqs_ref) = @_;
    my $min_diff = 1e9;
    my $best_idx = -1;
    for my $i (0 .. $#$freqs_ref) {
        my $diff = abs($freq - $freqs_ref->[$i]);
        if ($diff < $min_diff) {
            $min_diff = $diff;
            $best_idx = $i;
        }
    }
    return $best_idx;
}

print "Paste your dataset, one pair of hex values per line, separated by comma. Ctrl+D to end input.\n";

my $decoded = '';

while (<STDIN>) {
    chomp;
    next if /^\s*$/;  # skip empty lines
    my ($hex1, $hex2) = split /\s*,\s*/;

    # Convert to floats
    my $f1 = hex_to_float($hex1);
    my $f2 = hex_to_float($hex2);

    # Identify low and high frequency (low < high)
    my ($low, $high) = $f1 < $f2 ? ($f1, $f2) : ($f2, $f1);

    # Find closest matching indices
    my $low_idx = closest_freq_index($low, \@low_freqs);
    my $high_idx = closest_freq_index($high, \@high_freqs);

    if ($low_idx == -1 || $high_idx == -1) {
        $decoded .= '?';  # unknown tone
        next;
    }

    $decoded .= $dtmf_table[$low_idx][$high_idx];
}

print "\nDecoded DTMF string: $decoded\n";

