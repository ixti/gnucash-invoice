# internal
require 'gnucash'
require 'gnucash/invoice/version'
require 'gnucash/invoice/entry'
require 'gnucash/invoice/customer'
require 'gnucash/invoice/currency'
require 'gnucash/invoice/terms'
require 'gnucash/invoice/supplier'
require 'gnucash/invoice/printer'
require 'gnucash/invoice/runner'


module GnuCash
  class Invoice
    class InvoiceNotFound < StandardError; end


    include Timestamps


    attr_reader :raw, :id, :opened_at, :posted_at, :notes


    def initialize data
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
      unless @raw[:terms].nil?
        @terms ||= Terms.find @raw[:terms]
      end
    end


    def total
      entries.inject(0){ |memo,entry| memo + entry.total }
    end


    def to_s
      open_date = "(#{opened_at.strftime '%Y/%m/%d'})"
      post_date = ""

      if posted?
        post_date = "[#{posted_at.strftime '%Y/%m/%d'}]"
      end

      "%-16s %-32s %s %s" % [ id, customer.name, open_date, post_date ]
    end


    def self.all
      dataset.map{ |data| new(data) }
    end


    def self.find id
      unless data = dataset.where(:id => id).first
        raise InvoiceNotFound, "ID: #{id}"
      end

      new(data)
    end


    private


    def self.dataset
      GnuCash.connection[:invoices].where(:owner_type => 2)
    end
  end
end
