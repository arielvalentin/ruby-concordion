# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 

class ConcordionErrorCondition
  attr_reader :expected, :actual
  def initialize(expected, actual, xpath, context = nil, assert_true_command = false)
    @expected = expected
    @actual = actual
    @xpath = xpath
    @context = context
    @assert_true_command = assert_true_command
  end
  
  def to_s
    @expected = "true" if @assert_true_command
      
    base = "expected (#{@expected}) but got (#{@actual}) in tag: #{@xpath}"
    
    
    return base if @context.nil?
    
    base + "\n\tcontext of error: #{@context}"
  end
end
