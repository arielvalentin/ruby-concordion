# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'concordion_test_case'
class BasicAssertTrueTest < ConcordionTestCase
  def initialize(suite)
    super(suite, {:expected_failure_count => 1})
  end
  def is_boiling_point(temperature)
    212 == temperature.to_i
  end
end
