require 'test_helper'
require 'concordion_test_case'

class BasicTextTest < ConcordionTestCase
  def set_name(name)
    @name = name
  end

  def double_down
    "#{@name*2}"
  end
end
