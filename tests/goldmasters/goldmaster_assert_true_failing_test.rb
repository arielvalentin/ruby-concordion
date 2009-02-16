require 'test_helper'
require 'goldmaster_test_case'

class GoldmasterAssertTrueFailingTest < GoldmasterTestCase

  def expected_failure_count
    1
  end

  
  def getFalse
    false
  end
end
