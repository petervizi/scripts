use strict;

use LWP::UserAgent;
use XML::DOM;

use vars qw($VERSION %IRSSI);

$VERSION = '1.0';
%IRSSI = (
    authors	=> 'Peter Vizi',
    contact	=> 'peter.vizi@gmail.com',
    patch       => 'peter.vizi@gmial.com',
    name	=> 'donate',
    description	=> 'print the donate link to the screen',
    license	=> 'GPL',
);

our $ua = LWP::UserAgent->new;
$ua->agent("donate for irssi/1.0");

sub cmd_donate {
    my ($data, $server, $witem) = @_;
    my $api = "http://api.erepublik.com/v1/feeds/citizens/$data?by_username=true";
    my $req = HTTP::Request->new(GET => $api);
    my $res = $ua->request($req);
    my $response = "";
    if ($res->is_success) {
	my $parser = XML::DOM::Parser->new();
	my $doc = $parser->parse($res->content);
	my @cucc = $doc->getElementsByTagName('id');
	my $len = @cucc;
	my $id = $cucc[$len - 1]->getFirstChild->getNodeValue;
	$response = "$data http://www.erepublik.com/en/citizen/donate/items/$id";
    } else {
	$response = "fail";
    }
    if ($witem) {
	$witem->print($response);
    } else {
	Irssi::print($response);
    }
}
Irssi::command_bind('donate', 'cmd_donate');
