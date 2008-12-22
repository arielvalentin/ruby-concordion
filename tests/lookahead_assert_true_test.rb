require 'test_helper'
require 'concordion_test_case'

class LookaheadAssertTrueTest < ConcordionTestCase
  def starts_with(string, character)
    string[0] == character[0]
  end
  
  def not_starts_with(string, character)
    !starts_with(string,character)
  end


  def greeting_for(firstName)
    'Hello ' + firstName + '!'
  end
end
