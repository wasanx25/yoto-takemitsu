module Yoto
  module Takemitsu
    # core extension for Enumerable module
    module Enumerable
      ::Enumerable.module_eval do
        def uniq_merge(keys = [], values = [])
          self.group_by { |i| keys.map { |key| i[key] } }
              .map do |_k, v|
                v[1..-1].each { |x| values.each { |y| v[0][y] += x[y] } }
                v[0]
              end
        end
      end
    end
  end
end
