# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'

require 'concordion_test_methods'

class MixedTest < Test::Unit::TestCase
  include ConcordionTestMethods

  def easy
    "as pie"
  end
  def test_foo
    assert_equal "foo", "foo"
  end
end
