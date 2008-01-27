# ===========================================================================
# Copyright 2005, Everitz Consulting (mt@everitz.com)
#
# Licensed under the Open Software License version 2.1
# ===========================================================================
package MT::Plugin::Profiler;

use base qw(MT::Plugin);
use strict;

use MT;

# version
use vars qw($VERSION);
$VERSION = '0.1.0';

my $about = {
  name => 'MT-Profiler',
  description => 'Adds a link to the author list for editing profiles.',
  author_name => 'Everitz Consulting',
  author_link => 'http://www.everitz.com/',
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
