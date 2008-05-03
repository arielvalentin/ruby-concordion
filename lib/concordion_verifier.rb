require 'concordion_utility'

class ConcordionVerifier
  include ConcordionUtility

  attr_accessor :verification_variable
  def initialize(concordion)
    @concordion = concordion
    @verification_variable = nil
  end

  def update_if_verify_command(cpr)
    if cpr.is_verify_command?
      @verification_variable = cpr.assignment
    end
  end

  def update_verifier(idx)
    return if verification_variable.nil?
    arr = @concordion.get_variable(verification_variable)
    index = idx < 1 ? 0 : idx - 1

    value = arr[index]
    @concordion.set_variable(singular(verification_variable), value)
  end

  def verification_variable=(value)
    @verification_variable = value

    unless @verification_variable.nil?
      update_verifier(0)
    end
  end

end
