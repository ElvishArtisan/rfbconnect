#!/usr/bin/perl -W

# rfbconnect.pl
#
# Connect to a remote VNC server using a DNS 'RFB' SRV RR
#
#  (C) Copyright 2015 Fred Gleason <fredg@paravelsystems.com>
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License version 2 as
#   published by the Free Software Foundation.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public
#   License along with this program; if not, write to the Free Software
#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#  This script attempts to connect to the remote VNC server listed by
#  the local system's RFB SRV record in DNS by means of vncviewer(1).
#
#  The following environmental variables are understood:
#
#    $VNCVIEWER_CMD  The name of the program to invoke as the viewer.
#                    Defaults to 'vncviewer'.
#
#   $VNCVIEWER_OPTS  The options to pass to the vnc viewer program.
#                    Defaults to an empty string.
#

use Net::DNS;

my $usage="rfbconnect.pl";

#
# Read command-line
#
if(scalar @ARGV ne 0) {
  print $usage."\n";
  exit 256;
}

#
# Fetch the SRV Record
#
#  FIXME: We should examine all returned records and sort by priority.
#
my $res   = Net::DNS::Resolver->new;
my $reply = $res->query("_rfb._tcp.".$ENV{"HOSTNAME"}, "SRV");

if (!$reply) {
    print "rfbconnect.pl: no SRV RFB record found [", $res->errorstring, "]\n";
    exit 256;
}
my @fields=split /\s+/,($reply->answer)[0]->string;
if(scalar @fields lt 8) {
    print "rfbconnect.pl: SRV record is malformatted\n";
    exit 256;
}
my $hostname=$fields[7];
my $port=$fields[6];

#
# Launch the viewer
#
my $vnc_cmd=$ENV{"VNCVIEWER_CMD"};
if($vnc_cmd eq "") {
    $vnc_cmd="vncviewer";
}
my $cmd=$vnc_cmd." ".$ENV{"VNCVIEWER_OPTS"}." ".$hostname.":".$port;
system($cmd);
