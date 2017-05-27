module Yoto
  module Takemitsu
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
        if block_given?
          yield(self)
        else
          raise "You should set keys and values."
        end

        @obj.group_by { |i| @keys.map { |key| i[key] } }                
            .map { |_k, v|                                              
              v[1..-1].each { |x| @values.each { |y| v[0][y] += x[y] } }
              v[0]                                                      
            }                                                           
      end
    end
  end
end
