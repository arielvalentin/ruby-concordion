require 'test_helper'
require 'concordion_test_case'

class NestedElementLookaheadTest < ConcordionTestCase
  def greetingFor(name)
    "Hello #{name}!"
  end
end
