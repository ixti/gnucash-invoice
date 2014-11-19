module GnuCash
  class Invoice
    class Customer
      class CustomerNotFound < StandardError; end

      class << self
        def find(guid)
          attrs = dataset.where(:guid => guid).first

          fail CustomerNotFound, "GUID: #{guid}" unless attrs

          new attrs
        end

        def dataset
          GnuCash.connection[:customers]
        end
      end

      Address = Struct.new(:name, :phone, :fax, :email, :lines) do
        def self.build(attrs, prefix)
          args = %w(name phone fax email).map do |key|
            attrs[:"#{prefix}_#{key}"].to_s
          end

          args << (1..4).map do |i|
            attrs[:"#{prefix}_addr#{i}"].to_s
          end

          new(*args)
        end
      end

      include Timestamps

      attr_reader :attrs, :id, :name, :notes

      require "yaml"
      def initialize(attrs)
        @attrs  = attrs

        @id     = attrs[:id]
        @name   = attrs[:name]
        @notes  = attrs[:notes]
      end

      def billing_address
        @address ||= Address.build(attrs, "addr")
      end

      def shipping_address
        @address ||= Address.build(attrs, "shipaddr")
      end

      alias :to_s :name
    end
  end
end
