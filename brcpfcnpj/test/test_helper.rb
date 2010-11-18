ENV["RAILS_ENV"] = "test"

require "rubygems"
require "rails"
require 'rails/test_help'
require "active_record"
require "active_support"

require "brcpfcnpj"
ActiveRecord::Base.establish_connection(:adapter=>"sqlite3", :database => ":memory:")

require "db/create_testing_structure"
CreateTestingStructure.migrate(:up)

