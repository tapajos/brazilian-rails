# encoding: UTF-8
require "../test_helper"

module BrString
  module Generators
    module Tests
      class InstallGeneratorTest < Rails::Generators::TestCase 
        tests BrString::Generators::InstallGenerator
        destination File.expand_path(File.dirname(__FILE__), "tmp")
        setup :prepare_destination

        test "Verifica se o generator efetua a copia do arquivo de configuração br_string.rb" do
          run_generator
          assert_file "config/br_string.rb"
        end
        
      end
    end
  end
end

