require 'concordion_utility'
require 'concordion_lookahead_handler'
require 'concordion_verifier'
require 'concordion_invoker'
require 'concordion_binder'

# Concordion State  manages memory for Concordion specs as they are being parsed (e.g. when #var is declared in a spec, this class holds the memory reference).


class ConcordionState
  include ConcordionUtility

  @@TEXT_VAR = "#TEXT"
  def self.TEXT_VAR
    @@TEXT_VAR
  end
  attr_reader :verification_variable, :verifier

  def initialize
    @memory = {}
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
  

  # Deferences concordion method calls.
  # For example if memory held:
  # * #foo => 12
  # * #bar => 4
  # Then the following mappings hold:
  # * #foo => 12
  # * #foo.to_f => 12.0
  # * method(#foo, #bar) => method(12, 4)

  def dereference(conc_call)
    var_name = concordion_variable_name(conc_call)
    var = get_variable(var_name)

    if !has_property_reference?(conc_call)
      return var
    end

    var.send(concordion_property_reference(conc_call))
  end

  # Evaluate an expression
  # 1. Lookahead in the tag to see if needed variables are bound later.
  # 2. Bind a value to the variable from the spec, if needed.  Returns early if bound successfully.
  # 3. Update the current value of the iterator for verification commands, if needed.
  # 4. Invoke the system under test
  # 5. Bind a value to the variable on the left hand side of an equation, if needed.
  # 6. Hand the system under test return value to the concordion invoker, which makes the assertion.
  def evaluate(cpr, test_context, processor)
    @lookahead_handler.handle_lookahead(cpr, test_context, processor)

    return { :result => true } if @binder.bind_if_set_command(cpr) 

    @verifier.update_if_verify_command(cpr)

    sut_rv = @invoker.invoke_sut(cpr, test_context)
    @binder.handle_assignment(cpr, sut_rv)
    conc_rv = @invoker.invoke_concordion(cpr, sut_rv)
    
    conc_rv
  end

end
