# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'concordion_reader'

class ConcordionReaderTest < Test::Unit::TestCase
  def test_foo
    assert_raise RuntimeError do
      ConcordionReader.new.path_for("purple_monkey_dishwasher")
    end
  end
end
