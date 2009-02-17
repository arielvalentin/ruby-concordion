require 'test_helper'
require 'concordion_parse_result'
require 'rubygems'
require 'mocha'
class ConcordionParseResultTest < Test::Unit::TestCase

  def test_is_set_command
    assert ConcordionParseResult.new("set",nil,nil,nil).is_set_command?
    assert !ConcordionParseResult.new("asdf",nil,nil,nil).is_set_command?
  end

  def test_is_assert_image_command
    assert ConcordionParseResult.new("assert_image",nil,nil,nil).is_assert_image_command?
    assert !ConcordionParseResult.new("set",nil,nil,nil).is_assert_image_command?
  end

  def test_is_execute_command
    assert ConcordionParseResult.new("execute",nil,nil,nil).is_execute_command?
    assert !ConcordionParseResult.new("asdf",nil,nil,nil).is_execute_command?
  end

  def test_is_verify_command
    assert ConcordionParseResult.new("verifyrows",nil,nil,nil).is_verify_command?
    assert !ConcordionParseResult.new("monkeys",nil,nil,nil).is_verify_command?
  end
  def test_is_asserttrue_command
    assert ConcordionParseResult.new("asserttrue",nil,nil,nil).is_assert_true_command?
    assert !ConcordionParseResult.new("monkeys",nil,nil,nil).is_assert_true_command?
  end

  def test_image_location
    tag = mock("tag")
    tag.expects(:get_attribute).with('src').returns "foo" 
    assert_equal "foo", ConcordionParseResult.new(nil,nil,nil, tag).image_location
  end
  def test_assignment
    assert_equal "#user", ConcordionParseResult.new("verifyrows","  #user = asdfasdf",nil,nil).assignment
    assert_equal "#bob",  ConcordionParseResult.new("monkeys","#bob=asdf",nil,nil).assignment
  end
  
  def test_to_s
    assert_equal "Concordion command[], System under test method[#asdf], Tag Content[] Image Location[]", ConcordionParseResult.new(nil,"#asdf", nil,nil).to_s
  end
  def test_needs_dereference
    assert ConcordionParseResult.new(nil,"#asdf", nil,nil).needs_dereference?
    assert !ConcordionParseResult.new(nil,"asdf", nil,nil).needs_dereference?
    assert !ConcordionParseResult.new(nil,"as#df", nil,nil).needs_dereference?
    assert !ConcordionParseResult.new(nil,"#asdf = foo()", nil,nil).needs_dereference?
  end

end
