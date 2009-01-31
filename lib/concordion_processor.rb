require 'concordion_utility'

class ConcordionProcessor
  include ConcordionUtility

  def initialize(concordion, decorator)
    @concordion = concordion
    @decorator = decorator
  end

  def process(tag, test_context)
    attr = concordion_cmd_attr_for(tag)
    instrumented_value = tag.get_attribute(attr)
    cpr = create_parse_result(tag, attr, instrumented_value)
    rv = @concordion.evaluate(cpr, test_context, self)
    @decorator.decorate_tag(rv, tag, cpr)
  end

  def create_parse_result(tag, attr, value)
    ConcordionParseResult.new(instrumentation(attr), value, tag.inner_text, tag)
  end



end
