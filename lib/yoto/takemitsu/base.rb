module Yoto
  module Takemitsu
    # Hash in Array control
    class Base
      def initialize(obj)
        @obj = obj
      end

      def key(key);       @key    = key; end
      def keys(*key);     @keys   = key; end
      def value(value);   @value  = value; end
      def values(*value); @values = value; end
      def order(*order);  @orders = order; end

      def uniq_merge
        yield(self) if block_given?

        @obj.group_by { |i| @keys.map { |key| i[key] } }
            .map do |_k, v|
              v[1..-1].each { |x| @values.each { |y| v[0][y] += x[y] } }
              v[0]
            end
      end

      def original_sort
        yield(self) if block_given?

        @orders.each_with_object(String.new) do |order, result|
          result << @obj.find { |obj| obj[@key] == order.to_s }[@value]
        end
      end
    end
  end
end
