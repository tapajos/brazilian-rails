if Rails::VERSION::STRING >= '2.0.2'
  namespace :brazilianrails do
    namespace :inflector do
      namespace :portuguese do

        filename = 'config/initializers/inflector_portuguese.rb'
        src = "#{File.dirname(__FILE__).gsub("/tasks", '')}/#{filename}"
        dest = "#{RAILS_ROOT}/#{filename}"

        desc 'Enable Brazilian Portuguese inflectors.'
        task :enable do
          FileUtils.cp src, dest unless File.exist?(dest)
          check_status(dest)
        end

        desc 'Disable Brazilian Portuguese inflectors.'
        task :disable do
          FileUtils.rm [dest] if File.exist?(dest)
          check_status(dest)
        end
        
        desc 'Checks if Brazilian Portuguese inflectors is enabled/disabled.'
        task :check do
          check_status(dest)
        end
      end
    end
  end
end

def check_status(dest)
  puts 'Brazilian Portuguese inflectors is enabled.' if File.exist?(dest)
  puts 'Brazilian Portuguese inflectors is disabled.' unless File.exist?(dest)
end
