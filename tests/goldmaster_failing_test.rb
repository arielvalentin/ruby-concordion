require 'test_helper'
require 'goldmaster_test_case'

class GoldmasterFailingTest < GoldmasterTestCase  
  def initialize(suite)
    super(suite, {:expected_failure_count => 2}) #the other is the method missing error, check the goldmaster :)
  end
  def getGreeting
    "Hello World?"
  end
end
