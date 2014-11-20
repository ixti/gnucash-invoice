# stdlib
require "optparse"

module GnuCash
  class Invoice
    module Runner
      class << self
        def run(argv)
          options = parse argv

          unless options[:db]
            puts "ERROR: No database selected"
            exit 1
          end

          GnuCash.connect! options[:db]

          if options[:invoice_id]
            # Print out invoice
            puts Printer.new(options[:invoice_id], options[:template]).render
            exit 0
          end

          # Show known invoices
          Invoice.all.each { |invoice| puts invoice }
          exit 0
        rescue Sequel::DatabaseConnectionError
          puts "ERROR: Can't connect to database: #{options[:db].inspect}"
          exit 2
        rescue => e
          puts "ERROR: #{e}"
          exit 3
        end

        private

        def parse(argv)
          options = { :template => "templates" }

          OptionParser.new do |opts|
            opts.on("--dbpath [DATABASE]",
              "SQLite database path") do |path|
              puts "WARNING: --dbpath is deprecated use --db-path instead"
              options[:db] = path
            end

            opts.on("-d", "--db-path [DATABASE]",
              "SQLite database path") do |path|
              options[:db] = path
            end

            opts.on("-t", "--template [TEMPLATE]",
              "Template directory path") do |path|
              options[:template] = path
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
