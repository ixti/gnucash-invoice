# stdlib
require "optparse"
require "config"

module GnuCash
  class Invoice
    module Runner
      class << self

        USAGE = "Usage:\n\n  gnucash-invoice [OPTIONS] [invoice-ID]\n\nOptions:\n\n"
        EXAMPLE = "\nExamples:

    $ gnucash-invoice -d path-to-sqlitedb inv-1234
    $ gnucash-invoice -a mysql -h db.somewhere.net -d dbname -u user -p sekreet
"

        def run(argv)

          options = parse argv

          case options[:adapter]
          when 'sqlite'
            GnuCash.connect! options[:db]
          when 'mysql'
            GnuCash.connect_mysql!(
              options[:host], options[:user],
              options[:password], options[:db]
            )
          else
            abort("ERROR: #{options[:adapter]}: unsupported DB adapter")
          end

          # Useless?
          # unless options[:db]
          #   abort("ERROR: No database selected for #{options[:adapter]}")
          # end

          if options[:invoice_id]
            # Print out invoice
            puts Printer.new(options[:invoice_id], options[:template]).render
            exit 0
          end

          # Show known invoices
          puts INVOICE_LIST_HDR
          puts INVOICE_LIST_FMT % [
                 'Invoice ID', 'Customer', 'Reference', 'Opened at', 'Posted at',
                 'Due at'
               ]
          puts INVOICE_LIST_HDR
          Invoice.all.each { |invoice| puts invoice }

          exit 0

        rescue OptionParser::ParseError, OptionParser::MissingArgument => e
          abort("ERROR: #{e.message}\n#{USAGE}  (see #{$0} -H)")

        rescue GnuCash::NoDatabaseFound,
               GnuCash::NoDatabaseConnection,
               Sequel::DatabaseConnectionError => e
          abort("ERROR: #{options[:db].inspect}: Can't connect to database: #{e}")

        # other exceptions beyond this point are *bugs*
        # rescue => e
        #   abort("ERROR: #{options[:db].inspect}: #{e}")

        end

        private

        def parse(argv)
          options = {
            :adapter    => "sqlite",
            :host       => "localhost",
            :template   => "templates",
            :user       => "root"
          }

          OptionParser.new do |opts|

            opts.banner = USAGE


            # validation by regex looks broken :-(
            # <https://bugs.ruby-lang.org/issues/14728>
            # <https://bugs.ruby-lang.org/issues/10021>
            opts.on(
              '-a', '--adapter', '=ADAPTER', %w[sqlite mysql],
              'DB adapter, one in [mysql,sqlite]. Default "sqlite"'
            ) do |adapter|
              options[:adapter] = adapter
            end

            opts.on(
              '-d', '--db-path', '=DATABASE',
              'DB path (SQLite) OR name (MySQL)',
            ) do |path|
              options[:db] = path
            end

            opts.on(
              '-t', '--template', '=TEMPLATE',
              'Template directory path'
            ) do |path|
              options[:template] = path
            end

            opts.on(
              '-h', '--host', '=HOST[:PORT]',
              'MySQL host. Default: "localhost" (PORT ignored with this)'
            ) do |host|
              # TO-DO: canonicalize URI?
              options[:host] = host
            end

            opts.on(
              '-u', '--user', '=USER', 'MySQL DB user. Default: "root"'
            ) do |user|
              options[:user] = user
            end

            opts.on(
              '-p', '--password', '=PASSWORD', 'MySQL DB password'
            ) do |password|
              options[:password] = password
            end

            opts.on('-H', '--help', 'Prints this help') do
              puts opts
              puts EXAMPLE
              exit
            end

            opts.parse! argv
          end

          options[:invoice_id] = argv.first

          options
        end
      end
    end
  end
end
