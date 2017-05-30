module Yoto
  module Takemitsu
    # Hash in Array control
    class Base
      def initialize(obj)
        @obj = obj
      end

      def keys(*key)
        @keys = key
      end

      def values(*value)
        @values = value
      end

      def uniq_merge
        yield(self) if block_given?

        @obj.group_by { |i| @keys.map { |key| i[key] } }
            .map do |_k, v|
              v[1..-1].each { |x| @values.each { |y| v[0][y] += x[y] } }
              v[0]
            end
      end
    end
  end
end
