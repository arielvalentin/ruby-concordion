

class ConcordionParseResultTest < Test::Unit::TestCase

  def test_is_set_command
    assert ConcordionParseResult.new("set",nil,nil,nil).is_set_command?
    assert !ConcordionParseResult.new("asdf",nil,nil,nil).is_set_command?
  end

  def test_is_execute_command
    assert ConcordionParseResult.new("execute",nil,nil,nil).is_execute_command?
    assert !ConcordionParseResult.new("asdf",nil,nil,nil).is_execute_command?
  end

  def test_is_verify_command
    assert ConcordionParseResult.new("verifyrows",nil,nil,nil).is_verify_command?
    assert !ConcordionParseResult.new("monkeys",nil,nil,nil).is_verify_command?
  end

  def test_assignment
    assert_equal "#user", ConcordionParseResult.new("verifyrows","  #user = asdfasdf",nil,nil).assignment
    assert_equal "#bob",  ConcordionParseResult.new("monkeys","#bob=asdf",nil,nil).assignment
  end
  
  def test_needs_dereference
    assert ConcordionParseResult.new(nil,"#asdf", nil,nil).needs_dereference?
    assert !ConcordionParseResult.new(nil,"asdf", nil,nil).needs_dereference?
    assert !ConcordionParseResult.new(nil,"as#df", nil,nil).needs_dereference?
    assert !ConcordionParseResult.new(nil,"#asdf = foo()", nil,nil).needs_dereference?
  end

end
