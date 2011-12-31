require 'active_record'

module ActiveRecord
  class BaseWithoutTable < Base
    self.abstract_class = true

    def create_or_update
      errors.empty?
    end

    def save
      self.valid?
    end
    
    def column_for_attribute(name)
      self.class.columns_hash[name.to_s]
    end
    
    class << self
      def columns()
        @columns ||= []
      end

      def column(name, sql_type = nil, default = nil, null = true)
        columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
        reset_column_information
      end

      # Do not reset @columns
      def reset_column_information
        undefine_attribute_methods
        @column_names = @columns_hash = @content_columns = @dynamic_methods_hash = @read_methods = nil
      end
      
      def columns_hash
        hash = {}
        columns.each do |column|
          hash[column.name] = column
        end
        hash
      end
      
      def column_defaults
        defaults = {}
        columns.each do |column|
          defaults[column.name.to_sym] = nil
        end
        defaults
      end
    end
    
    private
      def self.attributes_protected_by_default
        []
      end
    
  end
end

