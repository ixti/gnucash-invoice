# stdlib
require 'ostruct'
require 'optparse'
require 'pathname'


module GnuCash
  class Invoice
    module Runner
      class InvalidArguments < StandardError; end


      def self.run argv
        options = parse argv

        GnuCash.connect! options.dbpath

        # Print out invoice
        unless argv.empty?
          puts Printer.new(options.invoice_id, options.template_path).render
          exit
        end

        # Show known invoices
        Invoice.all.each do |invoice|
          puts invoice
        end
      end


      protected


      def self.parse argv
        options = OpenStruct.new

        OptionParser.new do |opts|
          opts.on('-d', '--dbpath [DATABASE]', 'SQLite database path') do |path|
            options.dbpath = Pathname.new path
          end
          opts.on('-t', '--template [TEMPLATE]', 'Template directory path') do |path|
            options.template_path = Pathname.new path
          end
        end.parse! argv

        raise InvalidArguments, "No database selected" unless options.dbpath
        raise InvalidArguments, "Can't find specified database" unless options.dbpath.exist?

        options.invoice_id = argv.first

        options
      end
    end
  end
end
