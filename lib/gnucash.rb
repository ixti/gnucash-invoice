# 3rd-party
require "sequel"

# internal
require "gnucash/options"
require "gnucash/timestamps"

module GnuCash
  class NoDatabaseConnection < StandardError; end

  class << self
    def connection
      @connection || fail(NoDatabaseConnection)
    end

    def connect!(db)
      @connection = Sequel.connect "sqlite://#{db}"
    end

    def root
      @root ||= Pathname.new File.realpath(File.join(__FILE__, "../.."))
    end
  end
end
