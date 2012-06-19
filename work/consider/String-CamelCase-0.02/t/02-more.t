
use strict;
use warnings;
use Test::More tests => 22;
use String::CamelCase qw(camelize decamelize wordsplit);

# camelcases.
is(decamelize("HogeMuge"), "hoge_muge");
is(camelize("hoge_muge"),  "HogeMuge");

is(decamelize("AD"),             "ad");
is(decamelize("YearBBS"),        "year_bbs");
is(decamelize("ClientADClient"), "client_ad_client");
is(decamelize("ADClient"),       "ad_client");

is(camelize("ad"),               "Ad");
is(camelize("year_bbs"),         "YearBbs");
is(camelize("client_ad_client"), "ClientAdClient");
is(camelize("ad_client"),        "AdClient");

# split.
is_deeply([wordsplit("HogeMuge")],  [qw(Hoge Muge)]);
is_deeply([wordsplit("hoge_muge")], [qw(hoge muge)]);

is_deeply([wordsplit("AD")],             [qw(AD)]);
is_deeply([wordsplit("YearBBS")],        [qw(Year BBS)]);
is_deeply([wordsplit("ClientADClient")], [qw(Client AD Client)]);
is_deeply([wordsplit("ADClient")],       [qw(AD Client)]);

is_deeply([wordsplit("ad")],               [qw(ad)]);
is_deeply([wordsplit("year_bbs")],         [qw(year bbs)]);
is_deeply([wordsplit("client_ad_client")], [qw(client ad client)]);
is_deeply([wordsplit("ad_client")],        [qw(ad client)]);

# .
is(decamelize("_ADClient"),       "_ad_client");
is(decamelize(" _ADClient"),      " _ad_client");

# -----------------------------------------------------------------------------
# End of File.
# -----------------------------------------------------------------------------
