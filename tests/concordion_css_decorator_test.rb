require 'test_helper'
require 'concordion_css_decorator'
require 'rubygems'
require 'mocha'

class ConcordionCssDecoratorTest < Test::Unit::TestCase
  def test_does_not_write_if_file_exists
    writer = mock("writer")
    writer.expects(:output_file_exists?).with("concordion.css").once.returns(true)
    
    ConcordionCSSDecorator.new.add_css_file_to_output_dir(writer, :link)
  end
  
  def test_writes_if_file_does_not_exist
    writer = mock("writer")
    writer.expects(:output_file_exists?).with("concordion.css").once.returns(false)
    writer.expects(:calculate_filename_and_overwrite).with(anything, "concordion.css").once
    
    ConcordionCSSDecorator.new.add_css_file_to_output_dir(writer, :link)
  end

  def test_does_not_write_if_not_link_eg_inline
    writer = mock("writer")
    writer.expects(:output_file_exists?).with("concordion.css").once.returns(false)
    
    ConcordionCSSDecorator.new.add_css_file_to_output_dir(writer, :inline)
  end
end
