require 'slim'
require 'sass'
require 'sprockets'


module GnuCash
  class Invoice
    class Printer
      def initialize invoice_id, templates = "templates"
        @invoice   = Invoice.find(invoice_id)
        @templates = GnuCash.root.join(templates)
      end


      def embedded_asset pathname
        environment[pathname].to_s
      end


      def environment
        @environment ||= Sprockets::Environment.new(@templates).tap do |env|
          env.append_path 'assets/stylesheets'
          env.css_compressor = :sass
        end
      end


      def render
        template = Slim::Template.new @templates.join('invoice.slim').to_s
        template.render(self, {
          :invoice  => @invoice,
          :entries  => @invoice.entries,
          :customer => @invoice.customer,
          :options  => Options
        })
      end
    end
  end
end
