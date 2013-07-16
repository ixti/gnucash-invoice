module GnuCash
  class Invoice
    class Customer
      class CustomerNotFound < StandardError; end


      include Timestamps


      attr_reader :id, :name, :addr_name


      def initialize data
        @raw        = data

        @id         = data[:id]
        @name       = data[:name]
        @addr_name  = data[:addr_name]
      end


      def address_lines
        @address_lines ||= [].tap do |lines|
          (1..4).each do |i|
            id = :"addr_addr#{i}"
            lines << @raw[id] if @raw[id]
          end
        end
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
