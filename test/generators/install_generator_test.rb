# encoding: UTF-8
require File.dirname(__FILE__) + "/../test_helper.rb"

module BrazilianRails
  module Generators
    module Tests
      class InstallGeneratorTest < Rails::Generators::TestCase 
        tests BrazilianRails::Generators::InstallGenerator
        destination File.expand_path(File.dirname(__FILE__), "tmp")
        setup :prepare_destination

        test "Verifica se o generator efetua a copia do arquivo de configuração brazilian_rails.rb" do
          run_generator
          assert_file "config/brazilian_rails.rb"
        end
        
      end
    end
  end
end

