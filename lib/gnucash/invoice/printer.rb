require 'slim'
require 'sass'
require 'sprockets'


module GnuCash
  class Invoice
    class Printer
      def initialize invoice_id, template_path
        @invoice = Invoice.find(invoice_id)
        @template_path = template_path.nil? ? 'templates' : template_path
      end


      def embedded_asset pathname
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
        template.render(self, {
          :invoice  => @invoice,
          :entries  => @invoice.entries,
          :customer => @invoice.customer,
          :options  => Options
        })
      end


      protected


      def template_dir *args
        args.unshift @template_path
        GnuCash.root.join(*args)
      end
    end
  end
end
