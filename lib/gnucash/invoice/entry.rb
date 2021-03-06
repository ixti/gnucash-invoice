module GnuCash
  class Invoice
    class Entry
      include Timestamps

      attr_reader :raw, :date, :description, :action, :quantity, :price

      def initialize(data)
        @raw          = data

        @date         = from_timestamp(data[:date]).to_date
        @description  = data[:description]
        @action       = data[:action]
        @quantity     = data[:quantity_num].to_f / data[:quantity_denom]
        @price        = data[:i_price_num].to_f / data[:i_price_denom]
      end

      def total
        subtotal + tax.to_f
      end

      def taxable?
        1 == @raw[:i_taxable].to_i
      end

      def tax_included?
        taxable? && 1 == @raw[:i_taxincluded].to_i
      end

      def tax
        # to be done
      end

      def subtotal
        unless @subtotal
          @subtotal  = @price * @quantity
          @subtotal -= tax.to_f if tax_included?
        end

        @subtotal
      end

      class << self
        def find(invoice_guid)
          dataset.where(:invoice => invoice_guid).map { |data| new data }
        end

        private

        def dataset
          GnuCash.connection[:entries]
        end
      end
    end
  end
end
