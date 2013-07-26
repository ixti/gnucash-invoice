module GnuCash
  class Invoice
    class Terms

      attr_reader :raw, :description


      def initialize data
        @raw          = data

        @description  = data[:description]
      end

      alias :to_s :description

      def self.find guid
        unless data = dataset.where(:guid => guid).first
          raise TermsNotFound, "GUID: #{guid}"
        end

        new(data)
      end


      private


      def self.dataset
        GnuCash.connection[:billterms]
      end
    end
  end
end
