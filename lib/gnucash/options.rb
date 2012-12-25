module GnuCash
  module Options
    extend self


    def [] key
      data = dataset.where(:name => "options/#{key}").first

      return "[Unkown option #{key}" unless data

      case data[:slot_type]
      when 4 then data[:string_val]
      else "[Unknown data type for #{key}]"
      end
    end


    private


    def dataset
      GnuCash.connection[:slots]
    end
  end
end
