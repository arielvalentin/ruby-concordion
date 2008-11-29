require 'test_helper'

class ConcordionWriterTest < Test::Unit::TestCase
  def test_output_file_name

    assert_equal "bleh_test_output.html", ConcordionWriter.new.output_filename_for("bleh.html")


  end
end
