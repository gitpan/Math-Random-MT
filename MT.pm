# $Id: MT.pm,v 0.54 2001/05/09 00:57:30 ams Exp $
# Copyright 2001 Abhijit Menon-Sen <ams@wiw.org>

package Math::Random::MT;

use strict;
use Carp;
use DynaLoader;
use vars qw( @ISA $VERSION );

my $gen;
@ISA = qw( DynaLoader );
($VERSION) = q$Revision: 0.54 $ =~ /([\d.]+)/;

bootstrap Math::Random::MT $VERSION;

sub new
{
    my ($class, $seed) = @_;
    return Math::Random::MT::setup($seed);
}

sub rand
{
    my ($self, $N) = @_;
    if (ref $self) { return ($N    || 1) * $self->genrand(); }
    else           { return ($self || 1) * $gen-> genrand(); }
}
sub srand { $gen = new Math::Random::MT shift; }

sub import
{
    no strict 'refs';
    my $pkg = caller;

    foreach my $sym (@_) {
        if ($sym eq "srand" || $sym eq "rand") {
            *{"${pkg}::$sym"} = \&$sym;
        }
    }
}

1;

__END__

=head1 NAME

Math::Random::MT - The Mersenne Twister PRNG

=head1 SYNOPSIS

use Math::Random::MT;

$gen = Math::Random::MT->new($seed);

print $gen->rand(3);

OR

use Math::Random::MT qw(srand rand);

# now srand and rand behave as usual.

=head1 DESCRIPTION

The Mersenne Twister is a pseudorandom number generator developed by
Makoto Matsumoto and Takuji Nishimura. It is described in their paper at
<URL:http://www.math.keio.ac.jp/~nisimura/random/doc/mt.ps>.

This module implements two interfaces, as described in the synopsis
above. It defines the following functions.

=head2 Functions

=over

=item new($seed)

Creates a new generator and seeds it appropriately.

=item rand($num)

Behaves exactly like Perl's builtin rand(), returning a number uniformly
distributed in [0, $num) ($num defaults to 1).

=item srand($seed)

This is an alternative interface to the module's functionality. It
behaves just like Perl's builtin srand().

=back

=head1 SEE ALSO

<URL:http://www.math.keio.ac.jp/~matumoto/emt.html>

Math::TrulyRandom

=head1 ACKNOWLEDGEMENTS

=over 4

=item Sean M. Burke

For giving me the idea to write this module.

=back

=head1 AUTHOR

Abhijit Menon-Sen <ams@wiw.org>

Copyright 2001 Abhijit Menon-Sen. All rights reserved.

This software is distributed under the terms of the Artistic License
<URL:http://ams.wiw.org/code/artistic.txt>.
