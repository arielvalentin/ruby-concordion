require 'test_helper'
require 'concordion_test_case'

class BasicSetTest < ConcordionTestCase
  def greetingFor(name)
    "Hello #{name}, you nancy-boy."
  end
end
