$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

%w(version).each {|req| require File.dirname(__FILE__) + "/brI18n/#{req}"}

module BrI18n
  
  I18N_FILES = File.expand_path(File.dirname(__FILE__) + "/files")
  
end

I18n.load_path = Dir.glob("#{RAILS_ROOT}/config/locales/*") + Dir.glob("#{BrI18n::I18N_FILES}/*")
I18n.default_locale = 'pt-BR'
