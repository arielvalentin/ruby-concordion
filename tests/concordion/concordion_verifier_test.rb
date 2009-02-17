require 'test_helper'
require 'concordion'
require 'concordion_verifier'

class ConcordionVerifierTest < Test::Unit::TestCase

  def setup
    @concordion = ConcordionState.new
    @verifier = ConcordionVerifier.new(@concordion)
  end



  def test_update_does_not_blow_up_if_verification_variable_unset
    @verifier.verification_variable = nil
    @verifier.update_verifier(1)
  end

  def test_update_verification
    assert @concordion.get_variable("#user").nil?
    @concordion.set_variable("#users", ["A", "B", "C"])
    @verifier.verification_variable = "#users" 
    @verifier.update_verifier(2) # will be one larger because of the header row
    
    assert_equal "B", @concordion.get_variable("#user")
  end


  def test_update_verification_automatically_sets_to_zero
    assert @concordion.get_variable("#user").nil?
    @concordion.set_variable("#users", ["A", "B", "C"])
    @verifier.verification_variable = "#users" 
    
    assert_equal "A", @concordion.get_variable("#user")
  end


end
