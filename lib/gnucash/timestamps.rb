module GnuCash
  module Timestamps
    FORMAT = "%Y%m%d%H%M%S"


    def from_timestamp value
      case value
      when ::DateTime           then value
      when ::Numeric, /\A\d+\z/ then parse value.to_s
      when ::String, /\A\d+\z/  then parse value
      end
    end


    private


    def parse str
      ::DateTime.strptime str, FORMAT
    end
  end
end

