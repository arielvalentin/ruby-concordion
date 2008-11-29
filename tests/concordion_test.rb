require 'test/unit'
require 'test_helper'
require 'concordion'

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
