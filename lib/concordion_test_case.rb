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
require 'test/unit'

require 'concordion_test_methods'


class ConcordionTestCase < Test::Unit::TestCase

  include ConcordionConfigMethods
  extend ConcordionConfigMethods
  include ConcordionInternalTestMethods
  class << self
    alias_method :original_inherited, :inherited
  end

  def self.inherited(subclass)
    original_inherited(subclass)
    bind_test_method_to(subclass, default_config)
  end

  def initialize(arg, conf = default_config())
    super(arg)
    @config = default_config.merge(conf)
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

end
