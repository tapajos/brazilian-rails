# encoding: UTF-8
require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/packagetask'
require 'rake/gempackagetask'
require 'rake/contrib/sshpublisher'

env = %(PKG_BUILD="#{ENV['PKG_BUILD']}") if ENV['PKG_BUILD']

PROJECTS = %w(brnumeros brdinheiro brcep brdata brhelper brstring brcpfcnpj brI18n)

Dir["#{File.dirname(__FILE__)}/*/lib/*/version.rb"].each do |version_path|
  require version_path
end

desc 'Run all tests by default'
task :default => :test

%w(test rdoc package release).each do |task_name|
  desc "Run #{task_name} task for all projects"
  task task_name do
    PROJECTS.each do |project|
      system %(cd #{project} && #{env} #{$0} #{task_name})
    end
  end
end

desc "install all gems"
task :install_all do
  PROJECTS.each do |project|
    Dir.entries("#{project}/pkg").select{ |d| d =~ /\.gem$/ }.each do |gem_file|
      system %(sudo gem install #{project}/pkg/#{gem_file})
    end
  end
  Dir.entries("./pkg").select{ |d| d =~ /\.gem$/ }.each do |gem_file|
    system %(sudo gem install ./pkg/#{gem_file})
  end
end

desc "remove old gem packages"
task :clean_packages do
  require 'fileutils'
  PROJECTS.each do |project|
    Dir.entries("#{project}/pkg").select{ |d| d =~ /#{project}/ }.each do |file|
      FileUtils.rm_rf(File.join(project,"pkg",file))
    end
  end
  Dir.entries("./pkg").select{ |d| d =~ /brazilian/ }.each do |file|
    FileUtils.rm_rf(File.join("./pkg", file))
  end  
end

desc "Generate documentation for the Brazilian Rails"
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title    = "Brazilian Rails Documentation"

  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.options << '-A cattr_accessor=object'
  rdoc.options << '--charset' << 'utf-8'
  rdoc.options << '-T html'
  rdoc.options << '--all'
  rdoc.options << '-U'
  

  rdoc.template = "#{ENV['template']}.rb" if ENV['template']
  
  rdoc.rdoc_files.include("README.mkdn")
  
  PROJECTS.each do |project|
    rdoc.rdoc_files.include("#{project}/README")
    rdoc.rdoc_files.include("#{project}/CHANGELOG")
    rdoc.rdoc_files.include("#{project}/lib/**/*.rb")
  end
  
end


PKG_VERSION = "2.1.9"

# Create compressed packages
spec = Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = "brazilian-rails"
  s.summary = "O Brazilian Rails é um conjunto de gems para facilitar a vida dos programadores brasileiros."
  s.description = %q{O Brazilian Rails é um conjunto de gems para facilitar a vida dos programadores brasileiros.}
  s.version = PKG_VERSION

  s.authors = ["Marcos Tapajós", "Celestino Gomes", "Andre Kupkosvki", "Vinícius Teles", "Cássio Marques"]
  s.email = "tapajos@gmail.com"
  s.rubyforge_project = "brazilian-rails"
  s.homepage = "http://www.improveit.com.br/software_livre/brazilian_rails"

  s.has_rdoc = true
  s.requirements << 'none'
  s.require_path = 'lib'
  
  PROJECTS.each do |project|
    s.add_dependency(project, ">= #{PKG_VERSION}")  
  end
  
  s.autorequire = PROJECTS
  
  s.files = [ "README.mkdn", "lib/brazilian-rails.rb"]
end
  
Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = true
  p.need_zip = true
end

desc "Publish the release files to RubyForge."
task :release => [ :package ] do
  require 'rubyforge'
  require 'rake/contrib/rubyforgepublisher'
  
  packages = %w( gem tgz zip ).collect{ |ext| "pkg/brazilian-rails-#{PKG_VERSION}.#{ext}" }
  
  rubyforge = RubyForge.new
  rubyforge.configure
  rubyforge.login
  rubyforge.add_release("brazilian-rails", "brazilian-rails", "REL #{PKG_VERSION}", *packages)
end

