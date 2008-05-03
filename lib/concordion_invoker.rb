class ConcordionInvoker
  def initialize(conc)
    @concordion = conc
    @builder = conc.invocation_builder
  end

  def invoke_sut(cpr, test_context)
    sut_rv = nil
    if cpr.needs_dereference?
      sut_rv = @concordion.dereference(cpr.system_under_test)
    else 
      invocation_str = @builder.build_invocation_string(cpr.system_under_test, cpr.content)
      sut_rv = test_context.instance_eval invocation_str
    end
    sut_rv
  end

end
