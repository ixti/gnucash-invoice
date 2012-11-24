# GnuCash::Invoice

GnuCash invoice printer for human beings.


## Installation

    $ gem install gnucash-invoice


## Usage

GnuCash invoice printer currently supports SQLite and the usage is dead simple.
List all invoices that can be printed:

    $ gnucash-invoice --dbpath /path/to/db.sqlite3

    #00004 Customer A (2012-11-24)
    #00005 Customer B (2012-11-24)
    ...

Print out invoice by it's number:

    $ gnucash-invoice --dbpath /path/to/db.sqlite3 00004 > invoice-00004.html


## TODO

* TESTS!!!
* Extract models into separate gem with multi-backend support.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
