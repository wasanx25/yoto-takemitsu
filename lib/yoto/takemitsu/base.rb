module Yoto
  module Takemitsu
    # Hash in Array control
    class Base
      def initialize(obj)
        @obj = obj
      end

      def uniq_merge(&block)
        self.instance_eval &block if block_given?

        @obj.group_by { |obj| @keys.map { |k| obj[k] } }
            .map do |_k, val|
              val[1..-1].each { |data| @values.each { |v| val[0][v] += data[v] } }
              val[0]
            end
      end

      def original_sort(&block)
        self.instance_eval &block if block_given?

        @order.each_with_object([]) do |name, result|
          result << @obj.find { |obj| obj[@key] == name.to_s }
        end
      end

      def get_by_original_sort(&block)
        self.instance_eval &block if block_given?
        
        original_sort.each_with_object("") do |obj, result|
          result << obj[@value]
        end
      end

      private

        def key(key);       @key    = key; end
        def keys(*key);     @keys   = key; end
        def value(value);   @value  = value; end
        def values(*value); @values = value; end
        def order(*order);  @order  = order; end
    end
  end
end
