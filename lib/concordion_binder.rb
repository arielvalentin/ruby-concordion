require 'concordion_utility'

class ConcordionBinder
  include ConcordionUtility

  def initialize(concordion)
    @concordion = concordion
  end
  def bind_if_set_command(cpr)
    if cpr.is_set_command?
      @concordion.set_variable(cpr.system_under_test, cpr.content)
      true
    else
      false
    end
  end

  def handle_assignment(cpr, sut_rv)
    if has_assignment?(cpr.system_under_test)
      @concordion.set_variable(concordion_assignment(cpr.system_under_test), sut_rv)
    end
  end

end
