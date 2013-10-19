package DDG::Spice::ReleaseDate;

use DDG::Spice;

primary_example_queries "release thor the dark world";
secondary_example_queries "thor release date";
description "Movie release information from TheMovieDB";
name "Release Date";
code_url "https://github.com/duckduckgo/zeroclickinfo-spice/blob/master/lib/DDG/Spice/ReleaseDate.pm";
icon_url "/i/http://www.themoviedb.org.ico";
topics "entertainment", "everyday";
category "entertainment";
attribution github => ['https://github.com/tophattedcoder','Tom Bebbington'];

spice to => 'http://api.themoviedb.org/3/search/movie?api_key={{ENV{DDG_SPICE_MOVIEDB_APIKEY}}}&query=$1&include_adult=false&callback={{callback}}';

my @triggers = ( 'release date', 'release', 'movie release' );

triggers startend => @triggers;

handle query_lc => sub {
    # spice triggers are called when a trigger is part of a hyphenated word
    # i.e.: asus rt-66nu
    # this makes sure that only space deliminated words fire this spice
    my $input = $_;
    map { return $input if $input =~ s/(^|\s)$_(\s|$)// and $input ne '' } @triggers;
    return;
};

1;