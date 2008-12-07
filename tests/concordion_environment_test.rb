require 'test_helper'
require 'concordion_environment'

class ConcordionEnvironmentTest < Test::Unit::TestCase

  def test_output_dir
    restore_env do
      ENV['OUTPUT_DIR'] = nil
      assert_equal ".", ConcordionEnvironment.output_dir
      ENV['OUTPUT_DIR'] = "foo/bar"
      assert_equal "foo/bar", ConcordionEnvironment.output_dir
    end
  end

  def test_clean_list
    restore_env do
      ENV['OUTPUT_DIR'] = nil
      assert_equal "./*_test_output.html", ConcordionEnvironment.clean_list
      ENV['OUTPUT_DIR'] = "foo/bar"
      assert_equal "foo/bar/*_test_output.html", ConcordionEnvironment.clean_list
    end

  end

  def restore_env
    orig = ENV['OUTPUT_DIR']
    yield
    ENV['OUTPUT_DIR'] = orig
  end
end
