# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'concordion_utility'
require 'concordion_reader'
require 'concordion_parser'
require 'concordion_processor'
require 'concordion_parse_result'
require 'concordion_test_case'
require 'concordion_writer'
require 'concordion_environment'
require 'concordion'
require 'concordion_css_decorator'
require 'concordion_utility'


module ConcordionConfigMethods
  

  def default_config
    concordion = Concordion.new
    parser = ConcordionParser.new(ConcordionReader.new, concordion)
    decorator = ConcordionCSSDecorator.new
    processor = ConcordionProcessor.new(concordion, decorator)
    { 
      :parser => parser,
      :writer => ConcordionWriter.new(ConcordionEnvironment.output_dir),
      :concordion => concordion,
      :decorator => decorator,
      :processor => processor,
      :write_goldmaster => false,
      :css_type => ConcordionEnvironment.css_type
    }
  end

  def bind_test_method_to(subclass, config)
    subclass.class_eval do
      define_method :test_spec do
        filename = snake_cased_test_name(subclass.to_s)
        parse_spec(filename,config)
        failures = run_spec(filename, config)
        report_spec(filename,config, failures)
      end
    end
    subclass
  end


end

module ConcordionInternalTestMethods
  @@EXPECTED_FAILURE_COUNT = 0
  include ConcordionUtility

  def parse_spec(filename,config)
    config[:parser].parse(filename)
    assert_concordion_document(config)
    config[:decorator].add_concordion_css_link(config[:parser].root, config[:parser].html, config[:css_type])
  end

  def run_spec(filename, config)
    failures = []
    config[:parser].each_eligible_concordion_element do |elem|
      failure = config[:processor].process(elem, self)
      failures << failure unless failure.nil?
    end
    failures
  end

  def report_spec(filename, config, failures)
    config[:decorator].add_css_file_to_output_dir(config[:writer], config[:css_type])

    writer = config[:writer]
    if self.class.method_defined?(:rcor_writer)
      writer = rcor_writer()
    end
    
    outfilename = writer.calculate_filename_and_overwrite(config[:parser].root, filename)
    assert_no_failures(outfilename, config, failures)
  end

  def assert_no_failures(outfilename, config, failures)
    expected = @@EXPECTED_FAILURE_COUNT

    if self.class.method_defined?(:expected_failure_count)
      expected = expected_failure_count()
    end

    message = build_message "#{show_failures(failures)}\nWrote output to #{outfilename}.", 
                            'Actual failure count <?> did not match expected <?>.',
                            failures.size, expected
    assert_block message do
      failures.size == expected
    end
  end

  def show_failures(failures)
    rv = ""
    failures.each_with_index do |failure, index|
      rv += "[Error:#{index + 1}] #{failure}\n"
    end
    rv
  end

  def assert_concordion_document(config)
    assert_equal "http://www.concordion.org/2007/concordion", config[:parser].html.get_attribute("xmlns:concordion")
  end
  
end

module ConcordionTestMethods
  include ConcordionInternalTestMethods
  extend  ConcordionConfigMethods

  class << self
    alias_method :original_included, :included
  end

  def self.included(cmod)
    original_included(cmod)
    conf = default_config
    cm = class << cmod
      include ConcordionConfigMethods
    end
    
    bind_test_method_to(cmod, conf)
  end
end
