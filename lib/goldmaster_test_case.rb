require 'concordion_test_case'
require 'concordion_string_writer'

require 'diff/lcs'
module FailConditionally
  def fail_if_write_still_enabled(cs, writer, data, name)
    if cs.method_defined?(:write_goldmaster!)
      writer.write(data, name)

      raise RuntimeError.new("Disable write to goldmaster (erase write_goldmaster! in #{cs})")
    end
  end

end
class GoldmasterTestCase < ConcordionTestCase
  include FailConditionally

  def initialize(suite, conf = {})
    @writer = ConcordionStringWriter.new

    config = ConcordionTestCase.default_config.merge(conf)
    @write_goldmaster = config[:write_goldmaster]    
    super(suite, config)
  end

  def rcor_writer
    @writer
  end
  def test_spec
    trivial
  end

  def writer
    ConcordionWriter.new
  end


  def teardown
    fail_if_write_still_enabled(self.class, writer, @writer.data, snake_cased_goldmaster_name(self.class.to_s))
    
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
  
end
