# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 

class ConcordionErrorCondition
  attr_reader :expected, :actual
  def initialize(expected, actual, xpath, context = nil)
    @expected = expected
    @actual = actual
    @xpath = xpath
    @context = context
  end
  
  def to_s
    base = "expected (#{@expected}) but got (#{@actual}) in tag: #{@xpath}"
    
    return base if @context.nil?
    
    base + "\n\tcontext of error: #{@context}"
  end
end
