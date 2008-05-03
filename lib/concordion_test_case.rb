require 'concordion_utility'
require 'concordion_reader'
require 'concordion_parser'
require 'concordion_processor'
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
        filename = snake_cased_test_name(subclass.to_s)
        parse_spec(filename)
        run_spec(filename)
        report_spec(filename)
      end
    end
    subclass
  end

  def self.default_config
    concordion = Concordion.new
    parser = ConcordionParser.new(ConcordionReader.new, concordion)
    decorator = ConcordionCSSDecorator.new
    processor = ConcordionProcessor.new(concordion, decorator)
    { :expected_failure_count => @@EXPECTED_FAILURE_COUNT,
      :parser => parser,
      :writer => ConcordionWriter.new,
      :concordion => concordion,
      :decorator => decorator,
      :processor => processor,
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
    @processor = config[:processor]
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

  def parse_spec(filename)
    @parser.parse(filename)
    assert_concordion_document
    @decorator.add_concordion_css_link(@parser.root, @parser.html)
  end

  def run_spec(filename)
    @failures = 0
    @parser.each_eligible_concordion_element do |elem|
      @failures += @processor.process(elem, self)
    end    
  end   

  def report_spec(filename)
    outfilename = @writer.calculate_filename_and_write(@parser.root, filename)
    assert_no_failures(@failures, outfilename)
  end

  def assert_no_failures(failures, outfilename)
    assert_equal @expected_failure_count, failures, "Wrote output to #{outfilename}"    
  end

  def assert_concordion_document
    assert_equal "http://www.concordion.org/2007/concordion", @parser.html.get_attribute("xmlns:concordion")
  end
end
