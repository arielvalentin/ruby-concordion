require 'test/unit'

class ConcordionTest < Test::Unit::TestCase

  def setup
    @concordion = Concordion.new
    @thingy = Thingy.new()
  end

  def test_set_variable
    @concordion.set_variable("#foo", "bar")

    assert_equal "bar", @concordion.get_variable("#foo")
  end

  def test_build_invocation_string
    assert_equal "self.send('foo')", @concordion.build_invocation_string("foo()", "content")
    @concordion.set_variable("#bar", "baz")
    assert_equal "self.send('foo', 'baz')", @concordion.build_invocation_string("foo(#bar)", "content")

    @concordion.set_variable("#purplemonkey", "dishwasher")
    assert_equal "self.send('other', 'baz', 'dishwasher')", @concordion.build_invocation_string("other(#bar,  #purplemonkey)", "content")
  end

  def test_build_invocation_string_replaces_text
    assert_equal "self.send('foo', 'ASDF')", @concordion.build_invocation_string("foo(#TEXT)", "ASDF")
    
  end

  def test_update_does_nothing_if_verification_variable_unset
    @concordion.verification_variable = nil
    @concordion.update_verifier(1)
  end

  def test_update_verification
    assert @concordion.get_variable("#user").nil?
    @concordion.set_variable("#users", ["A", "B", "C"])
    @concordion.verification_variable = "#users" 
    @concordion.update_verifier(2) # will be one larger because of the header row
    
    assert_equal "B", @concordion.get_variable("#user")
  end


  def test_update_verification_automatically_sets_to_zero
    assert @concordion.get_variable("#user").nil?
    @concordion.set_variable("#users", ["A", "B", "C"])
    @concordion.verification_variable = "#users" 
    
    assert_equal "A", @concordion.get_variable("#user")
  end


  def test_dereference
    @concordion.set_variable("#result", @thingy)

    assert_same @thingy, @concordion.dereference("#result")
  end
  def test_dereference_with_property
    @concordion.set_variable("#result", @thingy)

    assert_equal "bleh", @concordion.dereference("#result.prop")
  end

  class Thingy
    attr_accessor :prop
    def initialize
      @prop = "bleh"
    end
  end
end
