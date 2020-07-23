#!/usr/bin/env perl6

use Cro::HTTP::Router;
use Cro::HTTP::Server;

my $application = route {
    get -> {
        content 'text/html', '<html><body><h1>Hello Isinsu!</h1></body></html>';
    }
    get -> 'articles', $author, $name {
        content 'text/html', "<html><body><h1>{$name}<h1><em>By {$author}</em></body></html>";
    }
}

my Cro::Service $service = Cro::HTTP::Server.new:
    :host<localhost>, :port<10000>, :$application;

$service.start;

react whenever signal(SIGINT) {
    $service.stop;
    exit;
}
