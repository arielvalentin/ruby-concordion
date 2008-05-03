require 'concordion_utility'


class ConcordionInvocationStringBuilder
  include ConcordionUtility
  def initialize(concordion)
    @concordion = concordion
  end
  
  def build_invocation_string(conc_call, content)
    base = "self.send('#{concordion_method_name(conc_call)}'"
    if has_arguments?(conc_call)
      arg_vars = concordion_arguments(conc_call)
      arg_values = arg_vars.collect {|var| "'#{@concordion.get_variable(var)}'" }
      
      args = arg_values.join(", ")
      base += ", " + args
    end

    rv = base + ")"

    rv.gsub(Concordion.TEXT_VAR, content)
  end
end
