require 'test_helper'
require 'concordion_test_case'

class RubyishTest < ConcordionTestCase

  def no_args
    "foo"
  end
  
  def return_arg(arg)
    arg
  end
  
  def concat(a,b)
    raise "second arg nil" if b.nil?
    raise "first arg nil" if a.nil?
    
    "#{a}:#{b}"
  end
end
