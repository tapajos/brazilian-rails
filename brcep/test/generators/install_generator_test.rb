# encoding: UTF-8

require File.join(File.expand_path(File.dirname(__FILE__)), "../test_helper.rb")

module BrCep
  module Generators
    module Tests
      class InstallGeneratorTest < Rails::Generators::TestCase 
        tests BrCep::Generators::InstallGenerator
        destination File.expand_path(File.dirname(__FILE__), "tmp")
        setup :prepare_destination

        test "Verifica se o generator efetua a copia do arquivo de configuração br_cep.rb" do
          run_generator
          assert_file "config/br_cep.rb"
        end
        
      end
    end
  end
end
