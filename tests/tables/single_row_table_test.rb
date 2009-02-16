require 'test_helper'
require 'concordion_test_case'
require 'single_row_result'

class SingleRowTableTest < ConcordionTestCase
  def split_by_colons(text)
    SingleRowResult.new(text.split(":"))
  end
end
