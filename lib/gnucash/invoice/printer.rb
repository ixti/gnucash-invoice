require 'slim'
require 'sass'
require 'sprockets'


module GnuCash
  class Invoice
    class Printer
      def initialize invoice_id
        @invoice = Invoice.find(invoice_id)
      end


      def asset pathname
        environment[pathname].to_s
      end


      def environment
        @environment ||= Sprockets::Environment.new(template_dir).tap do |env|
          env.append_path 'assets/stylesheets'
          env.css_compressor = :sass
        end
      end


      def render
        template = Slim::Template.new template_dir('invoice.slim').to_s
        template.render(self, :invoice => @invoice)
      end


      protected


      def template_dir *args
        args.unshift 'templates'
        GnuCash.root.join(*args)
      end
    end
  end
end
