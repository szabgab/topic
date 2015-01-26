package Topic::Crawler;
use Moose;
use 5.010;

use AnyEvent;
use AnyEvent::HTTP;


# given a domain name, crawl the whole site, save the titles and the URLs
my @domains = qw(http://perlmaven.com/);

sub run {
	my ($self) = @_;

	my $cv = AnyEvent->condvar;

	foreach my $url (@domains) {
		say $url;
		$cv->begin;
		http_get $url, sub {
			my ($html) = @_;
			say "$url received, Size: ", length $html;
			$cv->end;
		};
	}
	$cv->recv;

}


no Moose;
__PACKAGE__->meta->make_immutable;

