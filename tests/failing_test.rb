require 'test_helper'
require 'concordion_test_case'

class FailingTest < ConcordionTestCase

  def expected_failure_count
    3
  end

  def wrong_value4
    "wrong"
  end
  
  def wrong_value2
    "wrong"
  end
  def wrong_value
    "wrong"
  end

end

