# ===========================================================================
# A Movable Type plugin to add a link to the author for editing profiles.
# Copyright 2005 Everitz Consulting <everitz.com>.
#
# This program is free software:  You may redistribute it and/or modify it
# it under the terms of the Artistic License version 2 as published by the
# Open Source Initiative.
#
# This program is distributed in the hope that it will be useful but does
# NOT INCLUDE ANY WARRANTY; Without even the implied warranty of FITNESS
# FOR A PARTICULAR PURPOSE.
#
# You should have received a copy of the Artistic License with this program.
# If not, see <http://www.opensource.org/licenses/artistic-license-2.0.php>.
# ===========================================================================
package MT::Plugin::Profiler;

use base qw(MT::Plugin);
use strict;

use MT;

# version
use vars qw($VERSION);
$VERSION = '0.1.1';

my $about = {
  name => 'MT-Profiler',
  description => 'Add a link to the author for editing profiles.',
  author_name => 'Everitz Consulting',
  author_link => 'http://everitz.com/',
  version => $VERSION,
};
my $profiler = MT::Plugin::Profiler->new($about);
MT->add_plugin($profiler);

# bigpapi callbacks

MT->add_callback('bigpapi::template::list_author', 9, $profiler, \&add_profile_link);

sub add_profile_link {
  my ($cb, $app, $template) = @_;
  my $old = qq{</td>};
  $old = quotemeta($old);
  my $new = <<"HTML";
 <TMPL_UNLESS NAME=IS_ME><TMPL_IF NAME=IS_ADMINISTRATOR>(<a href="<TMPL_VAR NAME=SCRIPT_URL>?__mode=view&_type=author&id=<TMPL_VAR NAME=ID>">edit</a>)</TMPL_IF></TMPL_UNLESS></td>
HTML
  my $count = 0;
  $$template =~ s/($old)/if (++$count == 2) { $new } else { $1 }/gex;
}

1;
