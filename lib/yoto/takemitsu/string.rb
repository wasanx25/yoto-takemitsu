module Yoto
  module Takemitsu
    module String
      ::String.class_eval do
        def delicate_byte_size
          self.chars.map do |c|
            c.bytesize == 1 ? 1 : 2
          end.inject(:+)
        end

        def reduce_emoji
          self.each_char.select { |c| c.bytes.count < 4 }.join('')
        end
      end
    end
  end
end
