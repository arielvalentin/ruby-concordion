require 'rubygems'
require 'rake/rdoctask'
require 'rake/testtask'
require 'rake/packagetask'
require 'rake/gempackagetask'
require 'rake/clean'
require 'lib/concordion_environment'

CLEAN.include(ConcordionEnvironment.clean_list)


Rake::RDocTask.new do |rd|
  rd.main = "README"
  rd.rdoc_files.include("README", "lib/**/*.rb")
end

Rake::TestTask.new do |t|
  t.libs << "test-lib"
  t.libs << "tests"
  t.libs << "tests/goldmasters"
  t.libs << "tests/tables"
  t.libs << "tests/user-reported"
  t.test_files = FileList['tests/**/*_test.rb']
  t.verbose = true
end

task :default => [:clean, :clobber_rdoc, :rdoc, :test]

task :commit_prep => [:test, :clean, :clobber_rdoc]

PKG_FILES = FileList['**/*'].exclude(/_test_output\.html$/)
PKG_VERSION = '0.9.9'

spec = Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.summary = "Ruby Concordion"
  s.name = 'concordion'
  s.rubyforge_project = 'ruby-concordion'
  #TODO fix the above when the new rubyforge project is available
  s.version = PKG_VERSION
  s.author = 'Ben Goodspeed'
  s.email = 'ben@goodspeed-it.ca'
  s.homepage ="http://code.google.com/p/rcor/"
  s.add_dependency('hpricot', '>= 0.6')
  s.requirements << 'hpricot HTML parser'
  s.require_path = 'lib'
  s.has_rdoc = true
  s.rdoc_options << '--title' << 'Ruby Concordion' << '--main' << 'README' << '--line-numbers'
  s.files = PKG_FILES
end

Rake::GemPackageTask.new(spec) { |package|
  package.need_zip = true
  package.need_tar = true
}


require 'rcov/rcovtask'
Rcov::RcovTask.new do |t|
    t.libs << "test-lib"
  t.libs << "tests"
  t.libs << "tests/goldmasters"
  t.libs << "tests/tables"
  t.libs << "tests/user-reported"

    t.test_files = FileList['tests/**/*_test.rb']
    t.verbose = true
  end

