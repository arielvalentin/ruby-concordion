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
