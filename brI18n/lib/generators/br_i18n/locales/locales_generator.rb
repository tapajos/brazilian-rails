require "rails/generators"
module BrI18n
  module Generators
    class LocalesGenerator < Rails::Generators::Base
      source_root File.join(File.dirname(File.expand_path(__FILE__)), "../../../locales/")  
      desc = "Efetua uma cópia dos locales para a pasta do projeto, sendo assim possível criar suas customizações"
      
      def copy_files
        Dir.glob(File.join(File.dirname(File.expand_path(__FILE__)), "../../../locales/*.yml")).each do |file|
          copy_file file, "config/locales/#{File.split(file).last}"
        end
      end

    end
  end
end
