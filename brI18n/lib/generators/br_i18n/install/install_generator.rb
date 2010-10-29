module BrI18n
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.join(File.dirname(File.expand_path(__FILE__)), "/templates/")  
      desc = "Efetua a cópia do arquivo de configuração para dentro da aplicação" 

      def copy_files
        copy_file "br_i18n.rb", "config/br_i18n.rb"
      end

    end
  end
end
