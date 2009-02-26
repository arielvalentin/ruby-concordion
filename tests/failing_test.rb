require 'test_helper'
require 'concordion_test_case'

class FailingTest < ConcordionTestCase

  def expected_failure_count
    2
  end

  def wrong_value
    "wrong"
  end

end

