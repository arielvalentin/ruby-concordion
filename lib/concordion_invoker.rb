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
  def invoke_concordion(cpr, sut_rv)
    commands[cpr.concordion_command].call(sut_rv, cpr.content)
  end


  def commands
    cmds = {}
    cmds["assertequals"] = Proc.new { |a, b| { :result => a == b, :actual => a, :expected => b } }
    cmds["execute"] = Proc.new { |a,b| {:result => true, :actual => a, :expected => b } }
    cmds["verifyrows"] = Proc.new { |a,b| { :result => true, :actual => a, :expected => b } }
    cmds["asserttrue"] = Proc.new { |a, b| { :result => a, :actual => a,  :expected => true } }
    cmds
  end


end
