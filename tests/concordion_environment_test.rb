require 'test_helper'
require 'concordion_environment'

class ConcordionEnvironmentTest < Test::Unit::TestCase
  
  def test_output_dir
    restore_env do
      ENV[ConcordionEnvironment.output_dir_key] = nil
      assert_equal ".", ConcordionEnvironment.output_dir
      ENV[ConcordionEnvironment.output_dir_key] = "foo/bar"
      assert_equal "foo/bar", ConcordionEnvironment.output_dir
    end
  end

  def test_clean_list
    restore_env do
      ENV[ConcordionEnvironment.output_dir_key] = nil
      assert_equal "./*_test_output.html", ConcordionEnvironment.clean_list
      ENV[ConcordionEnvironment.output_dir_key] = "foo/bar"
      assert_equal "foo/bar/*_test_output.html", ConcordionEnvironment.clean_list
    end

  end

  def restore_env
    orig = ENV[ConcordionEnvironment.output_dir_key]
    yield
    ENV[ConcordionEnvironment.output_dir_key] = orig
  end
end
