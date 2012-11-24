module GnuCash
  class Invoice
    class Printer
      def initialize invoice_id
        @invoice = Invoice.find_by_id(invoice_id)
      end


      def render
        puts @invoice
      end
    end
  end
end
