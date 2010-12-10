module BrazilianRails
  module Generators
    class InstallGenerator < Rails::Generators::Base

      source_root File.dirname(__FILE__) + "/templates/"
      desc = "Efetua a cópia do arquivo de configuração para dentro da aplicação"       

      def copy_files
        copy_file "brazilian_rails.rb", "config/brazilian_rails.rb"
      end

    end
  end
end
