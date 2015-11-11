# Enumerable: How I fell in love with Ruby

This repository contains code snippets used in my presentation on Ruby's enumerable module. Ruby code was written to run on Ruby 2.2.

[Enumerable presentation on Slidedeck](https://speakerdeck.com/rossta/enumerable-how-i-fell-in-love-with-ruby)


## Usage

To run a sample, clone the repo and install the gems:

```bash
$ git clone https://github.com/rossta/loves-enumerable.git
$ gem install
```

Then simply run the code with the ruby executable.

```bash
$ ruby code/pascals_triangle.rb
```

You'll get the most out of this repo by inspecting the source along with following the presentation.

## Main Points

Use more of the Enumerable API
- look for more direct solutions
- read the docs

Learn how Enumerable methods are implemented
- it’s not magic
- implement Enumerable on your own
- create your own extensions

Encapsulate complexity of enumerating
- e.g. stream data to client,
- deferred data fetching

Provide Enumerators
- for any method that returns an enumerable with a block:
  return an enumerator when the block is missing

When to be Lazy
- for avoiding eager evaluation
- for filtering results over large collection

Embrace the functional flavor
- given the same inputs, you can expect the same results
- use Enumerables like Legos: as building blocks

## Resources

Many of the ideas and examples are adapted from other great sources. Please
check out the following to learn more.

#### General

* https://practicingruby.com/articles/building-enumerable-and-enumerator
* http://www.sitepoint.com/guide-ruby-collections-iii-enumerable-enumerator/
* http://jwb.io/20130114-building-sequences-with-enumerator.html
* https://speakerdeck.com/jeg2/10-things-you-didnt-know-ruby-could-do
* http://dgiim.github.io/blog/2015/08/24/ruby-enumerators/

#### Lazy Enumerators

* http://patshaughnessy.net/2013/4/3/ruby-2-0-works-hard-so-you-can-be-lazy
* http://railsware.com/blog/2012/03/13/ruby-2-0-enumerablelazy/
* http://blog.honeybadger.io/using-lazy-enumerators-to-work-with-large-files-in-ruby/
* https://gist.github.com/barmstrong/1323865 # processing large csv
* http://www.sitepoint.com/implementing-lazy-enumerables-in-ruby/

#### Streaming

* http://old.blog.phusion.nl/2014/08/03/why-rails-4-live-streaming-is-a-big-deal
* http://www.sitepoint.com/streaming-with-rails-4/
* http://smsohan.com/blog/2013/05/09/genereating-and-streaming-potentially-large-csv-files-using-ruby-on-rails

#### Code

* https://github.com/sferik/twitter/blob/master/lib/twitter/enumerable.rb
* https://github.com/bbatsov/powerpack/tree/master/lib/powerpack/enumerable
* https://github.com/rubinius/rubinius/blob/master/kernel/common/enumerator.rb
* https://github.com/rubyworks/facets

#### Data sources

* http://catalog.data.gov/dataset/college-scorecard
* http://www.gutenberg.org

#### Books

* The Well-Grounded Rubyist by David Black
