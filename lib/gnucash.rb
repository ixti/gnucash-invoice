# 3rd-party
require 'sequel'


# internal
require 'gnucash/timestamps'


module GnuCash
  class NoDatabaseConnection < StandardError; end


  def self.connection
    @connection or raise NoDatabaseConnection
  end


  def self.connect! db
    @connection = Sequel.connect "sqlite://#{db}"
  end
end
