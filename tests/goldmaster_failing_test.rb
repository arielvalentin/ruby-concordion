require 'test_helper'
require 'goldmaster_test_case'

require 'mocha'

class GoldmasterFailingTest < GoldmasterTestCase  
  def initialize(suite)
    super(suite, {:expected_failure_count => 9}) 
  end
  def getGreeting
    "Hello World?"
  end

  def get_3_plans
    plans = []
    plans << mock_plan_named("Cunning Plan A")
    plans << mock_plan_named("Cunning Plan B")
    plans << mock_plan_named("Cunning Plan C")
    plans
    
  end
  
  def get_plans
    plans = []
    plans << mock_plan_named("Cunning Plan 2")
    plans << mock_plan_named("Cunning Plan 3")
    plans
  end
  
  def mock_plan_named(name)
    plan = mock("plan")
    plan.stubs(:planName).returns name
    plan
  end
end

