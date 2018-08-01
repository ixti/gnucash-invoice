# GnuCash::Invoice

GnuCash invoice printer for human beings.


## Installation

    $ gem install gnucash-invoice


## Usage

GnuCash invoice printer currently supports SQLite and MySQL (gnucash-3.x) and
the usage is dead simple.

    $ gnucash-invoice --help


List all invoices that can be printed:

    $ gnucash-invoice --db-path /path/to/db.sqlite3

or:

    $ gnucash-invoice -a mysql -h db.somewhere.net -d dbname -u user -p sekreet

    -----------------------------------------------------------------------------
    Invoice ID   Customer      Reference     Opened at    Posted at    Due at
    -----------------------------------------------------------------------------
    0001         Customer A    Order #01     2016-12-31   2016-12-31   2017-01-30
    0002         Customer B    Service #02   2017-03-30   2017-03-30   2017-04-29
    ...


Print out invoice by it's number (ID) -- output is HTML:

    $ gnucash-invoice --db-path /path/to/db.sqlite3 00004 > invoice-00004.html


Here's how generated invoice will look like:

---

![Example output](https://pbs.twimg.com/media/A_PnovSCYAAsQBy.png:large)

---


Tested on Funtoo Linux as of 2018-07-26 with GnuCash-3.1 and Ruby-2.4.3 (RubyGems-2.6.14)


## TODO

* TESTS!!!
* Fix models backend to allow specify db host:port [OK]
* ??? Add backend for old-school XML format
* Use currency from an account book instead of hardcoded
* ??? Export into FreshBooks
* Built-in several templates
* Allow specify foot notice (using markdown)


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
