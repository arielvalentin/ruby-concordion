require 'test_helper'
require 'concordion_test_case'

class ApostropheTest < ConcordionTestCase

  def apostrophe
    "Apostrophe's"
  end
  
  def as_apostrophe_bs
    "As ' Bs"
  end
  
  def check(text)
    "A's"
  end
  
end
