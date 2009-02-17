require 'test_helper'
require 'concordion_test_methods'


class ArbitraryBaseTestCase < Test::Unit::TestCase
  def test_something_to_quiet_runit
    assert_equal 1,1
  end
end

class FailingWithSubclassTest < ArbitraryBaseTestCase
  include ConcordionTestMethods

  def expected_failure_count
    2
  end
  
  def getGreeting
    "Hello World?"
  end


end

