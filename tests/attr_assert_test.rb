require 'test_helper'
require 'concordion_test_case'

class AttrAssertTest < ConcordionTestCase

  attr_accessor :greeting
  
  def initialize(arg)
    super(arg)
    @greeting = "attribute based"
  end
  
end
