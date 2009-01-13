require 'rubygems'
require 'spec'
require File.expand_path(File.dirname(__FILE__) + "/../lib/brcpfcnpj")
require 'active_record'

ActiveRecord::Base.establish_connection(:adapter=>"sqlite3", :database => ":memory:")
require File.dirname(__FILE__) + "/db/create_testing_structure"

CreateTestingStructure.migrate(:up)
