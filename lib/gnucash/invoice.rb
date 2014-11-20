# internal
require "gnucash"
require "gnucash/invoice/version"
require "gnucash/invoice/entry"
require "gnucash/invoice/customer"
require "gnucash/invoice/currency"
require "gnucash/invoice/terms"
require "gnucash/invoice/supplier"
require "gnucash/invoice/printer"
require "gnucash/invoice/runner"

module GnuCash
  class Invoice
    class InvoiceNotFound < StandardError; end

    DATE_FMT = "%Y/%m/%d"

    include Timestamps

    attr_reader :raw, :id, :opened_at, :posted_at, :notes

    def initialize(data)
      @raw        = data

      @id         = data[:id]
      @opened_at  = from_timestamp data[:date_opened]
      @posted_at  = from_timestamp data[:date_posted]
      @notes      = data[:notes]
    end

    def posted?
      posted_at.is_a? DateTime
    end

    def customer
      @customer ||= Customer.find @raw[:owner_guid]
    end

    def entries
      @entries ||= Entry.find @raw[:guid]
    end

    def currency
      @currency ||= Currency.find @raw[:currency]
    end

    def terms
      @terms ||= Terms.find @raw[:terms] unless @raw[:terms].nil?
    end

    def total
      entries.reduce(0) { |a, e| a + e.total }
    end

    def to_s
      open_date = "(#{opened_at.strftime DATE_FMT})"
      post_date = "[#{posted_at.strftime DATE_FMT}]" if posted?

      format "%-16s %-32s %s %s", id, customer.name, open_date, post_date
    end

    class << self
      def all
        dataset.map { |data| new(data) }
      end

      def find(id)
        data = dataset.where(:id => id).first

        fail InvoiceNotFound, "ID: #{id}" unless data

        new data
      end

      private

      def dataset
        GnuCash.connection[:invoices].where(:owner_type => 2)
      end
    end
  end
end
