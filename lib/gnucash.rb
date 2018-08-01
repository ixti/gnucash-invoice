# 3rd-party
require "sequel"

# internal
require "gnucash/options"
require "gnucash/timestamps"

module GnuCash
  class NoDatabaseConnection < StandardError; end
  class NoDatabaseFound < StandardError; end

  class << self
    def connection
      @connection || raise(NoDatabaseConnection)
    end

    def connect!(db)
      # must check path *before* connecting
      # File.open(db)
      raise(NoDatabaseFound, "File not found or unreadable") unless File.readable?(db)
      @connection = Sequel.connect(
        adapter:  'sqlite',
        database:  db,
        test:      true
      )
    end

    def connect_mysql!(hostport, user, password, db)
      hp = hostport.split(':')
      @connection = Sequel.connect(
        adapter:   'mysql2',
        user:      user,
        host:      hp[0],
        port:      hp[1],   # always ignored on GNU/Linux when host == 'localhost'
        database:  db,
        password:  password,
        test:      true
      )
    end

    def root
      @root ||= Pathname.new File.realpath(File.join(__FILE__, "../.."))
    end
  end
end
