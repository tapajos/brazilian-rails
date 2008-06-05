require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rcov/rcovtask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the Brazilian Rails plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the Brazilian Rails plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Brazilian Rails'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc "Generate code coverage report for Brazilian Rails plugin."
Rcov::RcovTask.new do |t|
  t.test_files = FileList['test/*_test.rb']
  t.rcov_opts << '-x init.rb'
  t.rcov_opts << '-x dependency_list.rb'
  t.rcov_opts << '-x app'
  t.rcov_opts << '--rails'
  t.rcov_opts << '--charset UTF-8'
  t.verbose = true
end

