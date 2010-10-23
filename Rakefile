# encoding: UTF-8
require "rubygems"
require "rake"
require "rake/testtask"
require "rake/rdoctask"
require "rake/packagetask"
require "rake/gempackagetask"


env = %(PKG_BUILD="#{ENV["PKG_BUILD"]}") if ENV["PKG_BUILD"]

PROJECTS_WITH_TEST_UNIT = %w(brnumeros brdinheiro brcep brdata brhelper brstring brI18n)
PROJECTS_WITH_RSPEC = %w(brcpfcnpj)
PROJECTS = PROJECTS_WITH_TEST_UNIT + PROJECTS_WITH_RSPEC

Dir["#{File.dirname(__FILE__)}/*/lib/*/version.rb"].each do |version_path|
  require version_path
end

desc "Run all tests by default"
task :default => [:test, :spec]

desc "Run test/spec task for all projects with test unit"
task :test do
  PROJECTS_WITH_TEST_UNIT.each do |project|
    system %(cd #{project} && #{env} #{$0} test)
  end
end

desc "Run spec task for all projects with rspec"
task :spec do
  PROJECTS_WITH_RSPEC.each do |project|
    system %(cd #{project} && #{env} #{$0} spec)
  end
end

%w(rdoc package release).each do |task_name|
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
  require "fileutils"
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
  rdoc.rdoc_dir = "doc"
  rdoc.title    = "Brazilian Rails Documentation"

  rdoc.options << "--line-numbers" << "--inline-source"
  rdoc.options << "-A cattr_accessor=object"
  rdoc.options << "--charset" << "utf-8"
  rdoc.options << "-T html"
  rdoc.options << "--all"
  rdoc.options << "-U"


  rdoc.template = "#{ENV["template"]}.rb" if ENV["template"]

  rdoc.rdoc_files.include("README.mkdn")

  PROJECTS.each do |project|
    rdoc.rdoc_files.include("#{project}/README")
    rdoc.rdoc_files.include("#{project}/CHANGELOG")
    rdoc.rdoc_files.include("#{project}/lib/**/*.rb")
  end

end

PKG_VERSION = "3.0.0"

# Create compressed packages
spec = Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = "brazilian-rails"
  s.summary = "O Brazilian Rails é um conjunto de gems para facilitar a vida dos programadores brasileiros."
  s.description = %q{O Brazilian Rails é um conjunto de gems para facilitar a vida dos programadores brasileiros.}
  s.version = PKG_VERSION

  s.authors = ["Marcos Tapajós", "Celestino Gomes", "Andre Kupkosvki", "Vinícius Teles", "Felipe Barreto", "Rafael Walter", "Cassio Marques"]
  s.email = %w"tapajos@gmail.com tinorj@gmail.com kupkovski@gmail.com vinicius.m.teles@gmail.com felipebarreto@gmail.com rafawalter@gmail.com cassiommc@gmail.com"
  s.rubyforge_project = "brazilian-rails"
  s.homepage = "http://www.improveit.com.br/software_livre/brazilian_rails"

  s.has_rdoc = true
  s.requirements << "none"
  s.require_path = "lib"

  PROJECTS.each do |project|
    s.add_dependency(project, ">= #{PKG_VERSION}")
  end

  s.add_development_dependency "rake"

  s.autorequire = PROJECTS

  s.files = [ "README.mkdn", "lib/brazilian-rails.rb"]
end

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
end

desc "Publish the release files to RubyForge."
task :release => [ :package ] do
  `gem push pkg/brazilian-rails-#{PKG_VERSION}.gem`
end
