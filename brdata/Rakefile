# encoding: UTF-8
require "rubygems"
require "rake"
require "rake/testtask"
require "rdoc/task"
require "rake/packagetask"
require "rake/gempackagetask"

require File.join(File.dirname(__FILE__), "lib", "brdata", "version")

PKG_BUILD     = ENV["PKG_BUILD"] ? "." + ENV["PKG_BUILD"] : ""
PKG_NAME      = "brdata"
PKG_VERSION   = BrData::VERSION::STRING + PKG_BUILD
PKG_FILE_NAME = "#{PKG_NAME}-#{PKG_VERSION}"

desc "Default Task"
task :default => [ :test ]

# Run the unit tests
Rake::TestTask.new { |t|
  t.libs << "test"
  t.pattern = "test/*_test.rb"
  t.verbose = true
  t.warning = false
}

#Generate the RDoc documentation
Rake::RDocTask.new { |rdoc|
  rdoc.rdoc_dir = "doc"
  rdoc.title    = "Brazilian Rails -- Data"
  rdoc.options << "--line-numbers" << "--inline-source" << "-A cattr_accessor=object"
  rdoc.options << "--charset" << "utf-8"
  rdoc.template = "#{ENV["template"]}.rb" if ENV["template"]
  rdoc.rdoc_files.include("README", "CHANGELOG")
  rdoc.rdoc_files.include("lib/**/*")
}

# Create compressed packages
spec = Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = PKG_NAME
  s.summary = "brdata é uma das gems que compoem o Brazilian Rails"
  s.description = %q{brdata é uma das gems que compoem o Brazilian Rails}
  s.version = PKG_VERSION

  s.authors = ["Marcos Tapajós", "Celestino Gomes", "Andre Kupkosvki", "Vinícius Teles", "Felipe Barreto", "Rafael Walter", "Cassio Marques"]
  s.email = %w"tapajos@gmail.com tinorj@gmail.com kupkovski@gmail.com vinicius.m.teles@gmail.com felipebarreto@gmail.com rafawalter@gmail.com cassiommc@gmail.com"
  s.rubyforge_project = "brdata"
  s.homepage = "http://www.improveit.com.br/software_livre/brazilian_rails"

  s.add_dependency("actionpack", ">= 3.0.0")
  s.add_dependency("activesupport", ">= 3.0.0")

  s.add_development_dependency "rake"
  s.add_development_dependency "mocha"

  s.has_rdoc = true
  s.requirements << "none"
  s.require_path = "lib"
  # s.autorequire = "brdata"

  s.files = [ "Rakefile", "README", "CHANGELOG", "MIT-LICENSE" ]
  s.files = s.files + Dir.glob( "lib/**/*" ).delete_if { |item| item.include?( "\.svn" ) }
  s.files = s.files + Dir.glob( "test/**/*" ).delete_if { |item| item.include?( "\.svn" ) }
end

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
end

desc "Publish the release files to RubyForge."
task :release => [ :package ] do
  `gem push pkg/#{PKG_FILE_NAME}.gem`
end
