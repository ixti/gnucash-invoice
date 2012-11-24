module GnuCash
  class Invoice
    class Customer
      class CustomerNotFound < StandardError; end


      include Timestamps


      attr_reader :id, :name


      def initialize data
        @raw        = data

        @id         = data[:id]
        @name       = data[:name]
      end


      alias :to_s :name


      def self.find guid
        unless data = dataset.where(:guid => guid).first
          raise CustomerNotFound, "GUID: #{guid}"
        end

        new(data)
      end


      private


      def self.dataset
        GnuCash.connection[:customers]
      end
    end
  end
end
