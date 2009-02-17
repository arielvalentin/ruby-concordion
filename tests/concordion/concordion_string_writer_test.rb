# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'concordion_string_writer'

class ConcordionStringWriterTest < Test::Unit::TestCase
  def test_foo
    assert ConcordionStringWriter.new.output_file_exists?("this is a lie, i don't really exist, but thats ok for string writers")
  end
end
