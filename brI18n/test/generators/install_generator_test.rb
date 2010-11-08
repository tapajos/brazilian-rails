require File.dirname(__FILE__) + "/../test_helper"

module BrI18n
  module Generators
    module Tests
      class InstallGeneratorTest < Rails::Generators::TestCase
        tests BrI18n::Generators::InstallGenerator
        destination File.expand_path(File.dirname(__FILE__), "tmp")
        setup :prepare_destination

        test "Verifica se o generator efetua a copia do arquivo de configuração br_i18n.rb" do
          run_generator
          assert_file "config/br_i18n.rb"
        end

      end
    end
  end
end

