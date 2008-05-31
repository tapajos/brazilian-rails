ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../../../../config/environment")
require 'test_help'

class Test::Unit::TestCase
  self.use_transactional_fixtures = true

  self.use_instantiated_fixtures  = false

  require File.expand_path(File.dirname(__FILE__) + "/../init")
  require 'inflector_portuguese'
  
  def tornar_metodos_publicos(clazz)
    clazz.class_eval do
      private_instance_methods.each { |instance_method| public instance_method }
      private_methods.each { |method| public_class_method method } 
    end  
  end
  
  def p80 text
    p '*'*80
    p text
    p '*'*80
  end
  
end
