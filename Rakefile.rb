require 'rubygems'
require 'rake/testtask'
require 'rake/packagetask'
require 'rake/gempackagetask'
require 'rake/clean'

CLEAN.include('*_test_output.html')

Rake::TestTask.new do |t|
  t.libs << "test-lib"
  t.libs << "tests"
  t.test_files = FileList['tests/*_test.rb']
  t.verbose = true
end

task :default => [:clean, :test] 

PKG_FILES = FileList['**/*'].exclude(/_test_output\.html$/)
                     

spec = Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.summary = "Ruby based concordion"
  s.name = 'rcor'
  s.version = '0.6.2'
  s.requirements << 'hpricot'
  s.require_path = 'lib'
  s.autorequire = 'rake'
  s.files = PKG_FILES
end

Rake::GemPackageTask.new(spec) { |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
}
