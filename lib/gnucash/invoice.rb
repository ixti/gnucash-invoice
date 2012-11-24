# internal
require 'gnucash'
require 'gnucash/invoice/version'
require 'gnucash/invoice/entry'
require 'gnucash/invoice/customer'
require 'gnucash/invoice/supplier'
require 'gnucash/invoice/printer'
require 'gnucash/invoice/runner'


module GnuCash
  class Invoice
    class InvoiceNotFound < StandardError; end


    include Timestamps


    attr_reader :id, :opened_at, :posted_at


    def initialize data
      @id         = data[:id]
      @opened_at  = from_timestamp data[:date_opened]
      @posted_at  = from_timestamp data[:date_posted]
    end


    def posted?
      posted_at.is_a? DateTime
    end


    def to_s
      s = "##{id} [OPENED AT: #{opened_at}]"

      if posted?
        s << " [POSTED AT: #{posted_at}]"
      end

      s
    end


    def self.all
      dataset.map{ |data| new(data) }
    end


    def self.find_by_id id
      unless data = dataset.where(:id => id).first
        raise InvoiceNotFound, "Unknown ID #{id}"
      end

      new(data)
    end


    private


    def self.dataset
      GnuCash.connection[:invoices].where(:owner_type => 2)
    end
  end
end
