require "config"

module GnuCash
  module Timestamps

    def from_timestamp(value)
      case value
      when ::DateTime, ::Time   then value              # GnuCash-3.x
      when ::Numeric, /\A\d+\z/ then parse value.to_s
      when ::String, /\A\d+\z/  then parse value
      else fail "#{value}: don't know how to treat this timestamp"
      end
    end

    private

    def parse(str)
      ::DateTime.strptime(str, TIMESTAMP_SQLT_FMT).to_time
    end
  end
end
