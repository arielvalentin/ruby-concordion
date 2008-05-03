class Concordion
  @@TEXT_VAR = "#TEXT"

  attr_reader :verification_variable
  include ConcordionUtility
  def initialize
    @memory = {}
    @verification_variable = nil
    set_variable(@@TEXT_VAR, @@TEXT_VAR)
  end
  def set_variable(variable, value)
    @memory[variable] = value
  end

  def get_variable(variable)
    @memory[variable]
  end
  
  def verification_variable=(value)
    @verification_variable = value

    unless @verification_variable.nil?
      update_verifier(0)
    end
  end

  def build_invocation_string(conc_call, content)
    base = "self.send('#{concordion_method_name(conc_call)}'"
    if has_arguments?(conc_call)
      arg_vars = concordion_arguments(conc_call)
      arg_values = arg_vars.collect {|var| "'#{get_variable(var)}'" }
      
      args = arg_values.join(", ")
      base += ", " + args
    end

    rv = base + ")"

    rv.gsub(@@TEXT_VAR, content)
  end

  def dereference(conc_call)
    var_name = concordion_variable_name(conc_call)
    var = get_variable(var_name)

    if !has_property_reference?(conc_call)
      return var
    end

    var.send(concordion_property_reference(conc_call))
  end

  def is_element_setter?(elem)
    !elem.get_attribute('concordion:set').nil?
  end

  def evaluate(cpr, test_context)
    if cpr.is_execute_command?
      cpr.tag.search("/*[@]").each {|child|
        if is_element_setter?(child)
          test_context.process(child)
        end

      }
    end


    if cpr.is_set_command?
      set_variable(cpr.system_under_test, cpr.content)
      return { :result => true }
    end

    if cpr.is_verify_command?
      @verification_variable = cpr.assignment
    end
    sut_rv = invoke_sut(cpr, test_context)
    handle_assignment(cpr, sut_rv)
    commands[cpr.concordion_command].call(sut_rv, cpr.content)
  end


  def handle_assignment(cpr, sut_rv)
    if has_assignment?(cpr.system_under_test)
      set_variable(concordion_assignment(cpr.system_under_test), sut_rv)
    end
  end

  def invoke_sut(cpr, test_context)
    sut_rv = nil
    if cpr.needs_dereference?
      sut_rv = dereference(cpr.system_under_test)
    else 
      invocation_str = build_invocation_string(cpr.system_under_test, cpr.content)
      sut_rv = test_context.instance_eval invocation_str
    end
    sut_rv
  end

  def update_verifier(idx)
    return if verification_variable.nil?
    arr = @memory[verification_variable]
    index = idx < 1 ? 0 : idx - 1

    value = arr[index]
    @memory[singular(verification_variable)] = value
  end

  def commands
    cmds = {}
    cmds["assertequals"] = Proc.new { |a, b| { :result => a == b, :actual => a, :expected => b } }
    cmds["execute"] = Proc.new { |a,b| {:result => true, :actual => a, :expected => b } }
    cmds["verifyrows"] = Proc.new { |a,b| { :result => true, :actual => a, :expected => b } }
#    cmds["verifyrows"] = Proc.new { |a,b| raise Exception.new("verify called: #{a}\nb:#{b}") }
    cmds
  end


end
