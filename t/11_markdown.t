use Test::More tests => 19;
use Test::NoWarnings;
use_ok('Parse::BBCode::Markdown');
use strict;
use warnings;

my $p = Parse::BBCode::Markdown->new({
});

my @tests = (
    [ q#[size=7]big [b]bold[/b] text[/size]#,
        q#big *bold* text# ],
    [ q#[url=http://foo/]interesting [b]bold[/b] link[/url]#,
        q#[interesting *bold* link](http://foo/)# ],
    [ q#[url="http://foo/"]interesting [b]bold[/b] link[/url]#,
        q#[interesting *bold* link](http://foo/)# ],
    [ q#[url=/foo]interesting [b]bold[/b] link[/url]#,
        q#[interesting *bold* link](/foo)# ],
    [ q#[code=perl]say "foo";[/code]#,
        qq#Code perl:\n--------------------\n| say "foo";\n--------------------# ],
    [ q#[list=1][*]first[*]second[*]third[/list]#,
        qq#* first\n* second\n* third\n# ],
    [ q#[list=1][*]first with [url]foo[/url][*]second[*]third[/list]#,
        qq#* first with [url]foo[/url]\n* second\n* third\n# ],
    [ q#[list=1][*]first[*]second with [url]foo[/url][*]third[/list]#,
        qq#* first\n* second with [url]foo[/url]\n* third\n# ],
    [ q#[list=1][*]first[*]second with [url]foo[*]third[/list]#,
        qq#* first\n* second with [url]foo\n* third\n# ],
    [ q#[list=1][*]first[*]second with [url]foo and [b]bold[/b][*]third[/list]#,
        qq#* first\n* second with [url]foo and *bold*\n* third\n# ],
    [ q#[img]/path/to/image.png[/img]#,
        q#![/path/to/image.png](/path/to/image.png)# ],
    [ q#[img=/path/to/image.png]description[/img]#,
        q#![description](/path/to/image.png)# ],
    [ q#[img=/path/to/image.png]description [b]with bold[/b][/img]#,
        q#![description *with bold*](/path/to/image.png)# ],
    [ qq#text [quote="foo"][quote="bar"]inner quote[/quote]outer quote[/quote]#,
        qq#text foo:\n> bar:\n>> inner quote\n> outer quote\n# ],
    [ q#[quote="admin@2008-06-27 19:00:25"][quote="foo@2007-08-13 22:12:32"]test[/quote]test[/quote]#,
        qq#admin\@2008-06-27 19:00:25:\n> foo\@2007-08-13 22:12:32:\n>> test\n> test\n# ],
    # EXTRA
    [ q#[list=1][*]first with [url=http://foo/]foo[/url][*]second[*]third[/list]#,
        qq#* first with [foo](http://foo/)\n* second\n* third\n# ],
    [ q#[url]interesting [b]bold[/b] link[/url]#,
        q#[url]interesting *bold* link[/url]# ],
);

for (@tests) {
    my ($in, $exp) = @$_;
    my $parsed = $p->render($in);
    #warn __PACKAGE__.':'.__LINE__.": $parsed\n";
    cmp_ok($parsed, 'eq', $exp, "$in");
}
