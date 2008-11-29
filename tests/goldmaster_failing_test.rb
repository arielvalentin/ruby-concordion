require 'test_helper'
require 'goldmaster_test_case'

class GoldmasterFailingTest < GoldmasterTestCase  
  def initialize(suite)
    super(suite, {:expected_failure_count => 1})
  end
  def getGreeting
    "Hello World?"
  end
end
