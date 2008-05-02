require 'concordion_utility'
require 'concordion_reader'
require 'concordion_parser'
require 'concordion_parse_result'
require 'concordion_test_case'
require 'concordion_writer'
require 'concordion'
require 'concordion_css_decorator'
require 'test/unit'
class ConcordionTestCase < Test::Unit::TestCase

  @@EXPECTED_FAILURE_COUNT = 0

  include ConcordionUtility

  def self.inherited(subclass)
    subclass.class_eval do
      define_method :test_spec do
        run_spec(snake_cased_test_name(subclass.to_s))
      end
    end
    subclass
  end

  def self.default_config
    concordion = Concordion.new
    parser = ConcordionParser.new(ConcordionReader.new, concordion)
    { :expected_failure_count => @@EXPECTED_FAILURE_COUNT,
      :parser => parser,
      :writer => ConcordionWriter.new,
      :concordion => concordion,
      :decorator => ConcordionCSSDecorator.new,
      :write_goldmaster => false
    }
  end

  def initialize(arg, conf = ConcordionTestCase.default_config)
    super(arg)
    config = ConcordionTestCase.default_config.merge(conf)
    @parser = config[:parser]
    @writer = config[:writer]
    @concordion = config[:concordion]
    @decorator = config[:decorator]
    @expected_failure_count = config[:expected_failure_count]

  end

  def test_something_trivial_to_shut_runit_up
    assert true
    trivial
  end

  def trivial
    @trivial = true
  end
  def is_trivial?
    @trivial
  end

  def run_spec(filename)
    @parser.parse(filename)
    assert_concordion_document
    @decorator.add_concordion_css_link(@parser.root, @parser.html)

    failures = 0

    @parser.each_eligible_concordion_element do |elem, attr|
      failures += process(elem, attr, elem.get_attribute(attr))
    end
    
    outfilename = @writer.calculate_filename_and_write(@parser.root, filename)

    assert_no_failures(failures, outfilename)
  end   



  def assert_no_failures(failures, outfilename)
    assert_equal @expected_failure_count, failures, "Wrote output to #{outfilename}"    
  end


  def assert_concordion_document
    assert_equal "http://www.concordion.org/2007/concordion", @parser.html.get_attribute("xmlns:concordion")
  end


  def process(tag, attr, instrumented_value)
    rv = @concordion.evaluate(create_parse_result(tag, attr, instrumented_value), self)
    @decorator.decorate_tag(rv, tag)
  end


  def create_parse_result(tag, attr, value)
    ConcordionParseResult.new(instrumentation(attr), value, tag.inner_text)
  end


end
