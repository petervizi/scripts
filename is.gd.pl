use strict;

use IO::Socket;
use LWP::UserAgent;

use vars qw($VERSION %IRSSI);

$VERSION = '1.0';
%IRSSI = (
    authors	=> 'Peter Vizi',
    contact	=> 'peter.vizi@gmail.com',
    patch       => 'peter.vizi@gmial.com',
    name	=> 'is.gd',
    description	=> 'create an is.gd url from a long one',
    license	=> 'GPL',
);

sub url_encode {
    my $url = shift;
    $url =~ s/([\W])/"%" . uc(sprintf("%2.2x",ord($1)))/eg;
    return $url;
}

sub get_isgd {
    my $url = shift;
    $url = url_encode($url);
    my $ua = LWP::UserAgent->new;
    $ua->agent("is.gd.pl for irssi/1.0 ");
    my $req = HTTP::Request->new(GET => "http://is.gd/api.php?longurl=$url");
    my $res = $ua->request($req);
    if ($res->is_success) {
	my $short_url = $res->content;
	return $short_url;
    }
    return "";
}

sub cmd_isgd {
    my ($data, $server, $witem) = @_;
    my $answer = get_isgd($data);
    my $question = substr($data, 0, 10);
    if ($answer) {
	if ($witem) {
	    $witem->print("isgding $question $answer");
	} else {
	    Irssi::print("isgding $question $answer");
	}
    } else {
	Irssi::print("isgding failed.");
    }
}

Irssi::command_bind('isgd', 'cmd_isgd');
