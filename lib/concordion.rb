require 'concordion_utility'
require 'concordion_invocation_string_builder'
require 'concordion_lookahead_handler'
require 'concordion_verifier'
require 'concordion_invoker'

class Concordion
  @@TEXT_VAR = "#TEXT"
  def self.TEXT_VAR
    @@TEXT_VAR
  end
  attr_reader :verification_variable, :verifier, :invocation_builder
  include ConcordionUtility
  def initialize
    @memory = {}
    @invocation_builder = ConcordionInvocationStringBuilder.new(self)
    @lookahead_handler = ConcordionLookaheadHandler.new
    @verifier = ConcordionVerifier.new(self)
    @invoker = ConcordionInvoker.new(self)
    set_variable(@@TEXT_VAR, @@TEXT_VAR)
  end
  def set_variable(variable, value)
    @memory[variable] = value
  end

  def get_variable(variable)
    @memory[variable]
  end
  
  def build_invocation_string(conc_call, content)
    @invocation_builder.build_invocation_string(conc_call,content)
  end

  def dereference(conc_call)
    var_name = concordion_variable_name(conc_call)
    var = get_variable(var_name)

    if !has_property_reference?(conc_call)
      return var
    end

    var.send(concordion_property_reference(conc_call))
  end


  def evaluate(cpr, test_context)
    @lookahead_handler.handle_lookahead(cpr, test_context)

    if cpr.is_set_command?
      set_variable(cpr.system_under_test, cpr.content)
      return { :result => true }
    end

    @verifier.update_if_verify_command(cpr)

    sut_rv = @invoker.invoke_sut(cpr, test_context)
    handle_assignment(cpr, sut_rv)
    commands[cpr.concordion_command].call(sut_rv, cpr.content)
  end


  def handle_assignment(cpr, sut_rv)
    if has_assignment?(cpr.system_under_test)
      set_variable(concordion_assignment(cpr.system_under_test), sut_rv)
    end
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
