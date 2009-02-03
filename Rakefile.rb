require 'rubygems'
require 'rake/testtask'
require 'rake/packagetask'
require 'rake/gempackagetask'
require 'rake/clean'
require 'lib/concordion_environment'

CLEAN.include(ConcordionEnvironment.clean_list)

Rake::TestTask.new do |t|
  t.libs << "test-lib"
  t.libs << "tests"
  t.test_files = FileList['tests/*_test.rb']
  t.verbose = true
end

task :default => [:clean, :test] 

PKG_FILES = FileList['**/*'].exclude(/_test_output\.html$/)
PKG_VERSION = '0.9.2'                     

spec = Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.summary = "Ruby based concordion"
  s.name = 'rcor'
  s.version = PKG_VERSION
  s.author = 'Ben Goodspeed'
  s.email = 'b.goodspeed@gmail.com'
  s.add_dependency('hpricot', '>= 0.6')
  s.requirements << 'hpricot HTML parser'
  s.require_path = 'lib'
  s.autorequire = 'rake'
  s.files = PKG_FILES
end

Rake::GemPackageTask.new(spec) { |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
}
