require 'test_helper'
require 'goldmaster_test_case'

require 'mocha'

class GoldmasterTableBugTest < GoldmasterTestCase  
  def expected_failure_count
    1
  end
  
  def get_plans
    plans = []
    plans << mock_plan_named("Cunning Plan BUG")
    plans << mock_plan_named("Cunning Plan DEFECT")
    plans
  end
  
  def mock_plan_named(name)
    plan = mock("plan")
    plan.stubs(:planName).returns name
    plan
  end
end

