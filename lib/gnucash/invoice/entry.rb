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
        price * quantity
      end

      class << self
        def find(invoice_guid)
          dataset.where(:invoice => invoice_guid).map { |data| new(data) }
        end

        private

        def dataset
          GnuCash.connection[:entries]
        end
      end
    end
  end
end
