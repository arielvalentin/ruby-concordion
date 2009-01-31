require 'concordion_test_case'
require 'concordion_string_writer'

require 'diff/lcs'

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

      diffs = Diff::LCS.diff(@writer.data, goldmaster)
      pos = diffs[0].entries[0].position
      context_exp = goldmaster.slice(pos - 50, 100)
      context_act = @writer.data.slice(pos - 50, 100)
      
      assert_equal @writer.data, goldmaster, "First difference at #{pos} bytes into goldmaster:\n(#{context_exp}) goldmaster vs\n(#{context_act}) actual"
    end

  end
  
  def meths(o)
    (o.methods - Object.methods).sort
  end
end
