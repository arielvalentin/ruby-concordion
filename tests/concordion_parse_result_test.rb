

class ConcordionParseResultTest < Test::Unit::TestCase

  def test_is_set_command
    assert ConcordionParseResult.new("set",nil,nil).is_set_command?
    assert !ConcordionParseResult.new("asdf",nil,nil).is_set_command?
  end

  def test_is_verify_command
    assert ConcordionParseResult.new("verifyrows",nil,nil).is_verify_command?
    assert !ConcordionParseResult.new("monkeys",nil,nil).is_verify_command?
  end

  def test_assignment
    assert_equal "#user", ConcordionParseResult.new("verifyrows","  #user = asdfasdf",nil).assignment
    assert_equal "#bob",  ConcordionParseResult.new("monkeys","#bob=asdf",nil).assignment
  end
  
  def test_needs_dereference
    assert ConcordionParseResult.new(nil,"#asdf", nil).needs_dereference?
    assert !ConcordionParseResult.new(nil,"asdf", nil).needs_dereference?
    assert !ConcordionParseResult.new(nil,"as#df", nil).needs_dereference?
    assert !ConcordionParseResult.new(nil,"#asdf = foo()", nil).needs_dereference?
  end

end
