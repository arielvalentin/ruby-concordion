# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'goldmaster_test_case'
require 'mocha'

class GoldmasterTestCaseTest < Test::Unit::TestCase
  include FailConditionally

  def write_goldmaster!
    true
  end

  def test_blows_up_if_write_goldmaster_is_left_enabled
    assert_raise RuntimeError do
      writer = mock("writer")
      writer.expects(:write).with("foo", "bar.html")
      fail_if_write_still_enabled(self.class, writer, "foo", "bar.html")
    end
  end
end
