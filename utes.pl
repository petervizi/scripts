use strict;

use vars qw($VERSION %IRSSI);

$VERSION = '1.0';
%IRSSI = (
    authors	=> 'Peter Vizi',
    contact	=> 'peter.vizi@gmail.com',
    patch       => 'peter.vizi@gmial.com',
    name	=> 'utes',
    description	=> 'count backward and shout utes',
    license	=> 'GPL',
);

our $counter;
our $tag;
sub timer_command {
    my ($witem) = @_;
    if ($counter == -1) {
	Irssi::timeout_remove($tag);
	if ($witem) {
	    $witem->command("MSG ".$witem->{name}." \002Utes!\002");
	} else {
	    Irssi::print("Utes!");
	}
    } else {
	if ($witem) {
	    $witem->command("MSG ".$witem->{name}." \002$counter\002");
	} else {
	    Irssi::print($counter);
	}
    }
    $counter --;
}

sub cmd_utes {
    my ($data, $server, $witem) = @_;
    $counter = $data;
    $tag = Irssi::timeout_add(1000, \&timer_command, $witem);
}

Irssi::command_bind('utes', 'cmd_utes');
