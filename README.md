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
    
Here's how generated invoice will look like:

---

![Example](https://pbs.twimg.com/media/A_PnovSCYAAsQBy.png:large)

---


## TODO

* TESTS!!!
* Fix models backend to allow specify db host:port
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
