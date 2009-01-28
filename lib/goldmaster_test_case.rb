require 'concordion_test_case'
require 'concordion_string_writer'
class GoldmasterTestCase < ConcordionTestCase
  

  def initialize(suite, conf = {})
    @writer = ConcordionStringWriter.new

    config = ConcordionTestCase.default_config.merge({:writer => @writer}).merge(conf)
    @write_goldmaster = config[:write_goldmaster]    
    super(suite, config)
  end

  def test_spec
    trivial
  end


  def teardown
    if @write_goldmaster
      ConcordionWriter.new.write(@writer.data, snake_cased_goldmaster_name(self.class.to_s))

      assert !@write_goldmaster, "Disable write to goldmaster"
    end
    unless is_trivial?
      goldmaster = ConcordionReader.new.read(snake_cased_goldmaster_name(self.class.to_s))
      assert @writer.data.size > 0
      assert_equal @writer.data, goldmaster 
    end

  end
end
