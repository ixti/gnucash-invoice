module GnuCash
  class Invoice
    class Terms
      attr_reader :raw, :description

      def initialize(data)
        @raw          = data
        @description  = data[:description]
      end

      alias :to_s :description

      class << self
        def find(guid)
          data = dataset.where(:guid => guid).first
          fail TermsNotFound, "GUID: #{guid}" unless data

          new(data)
        end

        private

        def dataset
          GnuCash.connection[:billterms]
        end
      end
    end
  end
end
