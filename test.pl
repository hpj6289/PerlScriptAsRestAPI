#!/usr/local/bin/perl

use strict;
use warnings;

use JSON;
use Data::Dumper;
use LWP::Simple;
use JSON qw( decode_json );

if (scalar @ARGV != 1) {
       print "Usage: $0 hostname\n";
       exit;
}
my $host = $ARGV[0];

	my $url = "http://iims/solr/properties/select/?wt=json&rows=1&fl=dc_location&q=$host";
	my $json = get($url) or die "ERROR: Could not parse $url - $!\n";

my $decoded_json = decode_json($json);
print Dumper ($decoded_json);
 

	my $numFound = $decoded_json->{response}->{numFound};
	unless ($numFound) {
	        print "$host NOT_IN_ALCHEMY\n";
	        next;
	}
	my $location = $decoded_json->{response}->{docs}->[0]->{dc_location} || "UNKNOWN";
	print "$host $location\n";
