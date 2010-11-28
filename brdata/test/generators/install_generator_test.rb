# encoding: UTF-8
require File.dirname(__FILE__) + "/../test_helper.rb"

module BrData
  module Generators
    module Tests
      class InstallGeneratorTest < Rails::Generators::TestCase 
        tests BrData::Generators::InstallGenerator
        destination File.expand_path(File.dirname(__FILE__), "tmp")
        setup :prepare_destination

        test "Verifica se o generator efetua a copia do arquivo de configuração br_cep.rb" do
          run_generator
          assert_file "config/br_data.rb"
        end
        
      end
    end
  end
end

