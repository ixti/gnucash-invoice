module GnuCash
  class Invoice
    class Currency

      attr_reader :raw, :mnemonic


      def initialize data
        @raw          = data

        @mnemonic     = data[:mnemonic]
      end

      alias :to_s :mnemonic

      def self.find guid
        unless data = dataset.where(:guid => guid).first
          raise CurrencyNotFound, "GUID: #{guid}"
        end

        new(data)
      end


      private


      def self.dataset
        GnuCash.connection[:commodities]
      end
    end
  end
end
