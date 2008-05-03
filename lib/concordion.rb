require 'concordion_utility'
require 'concordion_invocation_string_builder'
require 'concordion_lookahead_handler'
require 'concordion_verifier'
require 'concordion_invoker'
require 'concordion_binder'

class Concordion
  include ConcordionUtility

  @@TEXT_VAR = "#TEXT"
  def self.TEXT_VAR
    @@TEXT_VAR
  end
  attr_reader :verification_variable, :verifier, :invocation_builder

  def initialize
    @memory = {}
    @invocation_builder = ConcordionInvocationStringBuilder.new(self)
    @lookahead_handler = ConcordionLookaheadHandler.new
    @verifier = ConcordionVerifier.new(self)
    @invoker = ConcordionInvoker.new(self)
    @binder = ConcordionBinder.new(self)
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


  def evaluate(cpr, test_context, processor)
    @lookahead_handler.handle_lookahead(cpr, test_context, processor)

    return { :result => true } if @binder.bind_if_set_command(cpr) 

    @verifier.update_if_verify_command(cpr)

    sut_rv = @invoker.invoke_sut(cpr, test_context)
    @binder.handle_assignment(cpr, sut_rv)
    @invoker.invoke_concordion(cpr, sut_rv)
  end



end
