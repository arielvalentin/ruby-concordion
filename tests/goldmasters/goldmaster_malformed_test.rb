require 'test_helper'
require 'concordion_test_case'
require 'goldmaster_test_case'

class GoldmasterMalformedTest < GoldmasterTestCase

  def expected_failure_count
    1  #Note that the other two seeming commands do not fail- they are not actually run
  end

end
