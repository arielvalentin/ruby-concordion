require 'test_helper'
require 'rubygems'
require 'mocha'
require 'concordion_writer'
class ConcordionWriterTest < Test::Unit::TestCase
  def test_output_file_name

    assert_equal "./bleh_test_output.html", 
                 ConcordionWriter.new.output_filename_for("bleh.html")
    assert_equal "./bleh_test_output.html", 
                 ConcordionWriter.new(nil).output_filename_for("bleh.html")
    assert_equal "foo/bleh_test_output.html", 
                 ConcordionWriter.new("foo").output_filename_for("bleh.html")


  end
  
  def test_output_file_exists
    File.expects(:exists?).with("foo/output.css").returns(true)
    File.expects(:exists?).with("foo/missing").returns(false)
    
    assert ConcordionWriter.new("foo").output_file_exists?("output.css")
    assert !ConcordionWriter.new("foo").output_file_exists?("missing")
  end
  
end
