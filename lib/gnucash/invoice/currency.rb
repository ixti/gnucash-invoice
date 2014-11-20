module GnuCash
  class Invoice
    class Currency
      attr_reader :raw, :mnemonic

      def initialize(data)
        @raw          = data
        @mnemonic     = data[:mnemonic]
      end

      alias :to_s :mnemonic

      class << self
        def find(guid)
          data = dataset.where(:guid => guid).first
          fail CurrencyNotFound, "GUID: #{guid}" unless data

          new(data)
        end

        private

        def dataset
          GnuCash.connection[:commodities]
        end
      end
    end
  end
end
