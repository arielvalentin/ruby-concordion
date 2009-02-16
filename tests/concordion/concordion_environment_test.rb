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
      assert_equal ["./*_test_output.html", "./concordion.css"], ConcordionEnvironment.clean_list
      ENV[ConcordionEnvironment.output_dir_key] = "foo/bar"
      assert_equal ["foo/bar/*_test_output.html", "foo/bar/concordion.css"], ConcordionEnvironment.clean_list
    end

  end

  def test_css_type_defaults_to_inline
    restore_env do      
      ENV[ConcordionEnvironment.css_type_key] = "link"
      assert_equal :link, ConcordionEnvironment.css_type
      
      ENV[ConcordionEnvironment.css_type_key] = nil
      assert_equal :inline, ConcordionEnvironment.css_type

    end

  end

  def restore_env
    orig_dir = ENV[ConcordionEnvironment.output_dir_key]
    orig_type = ENV[ConcordionEnvironment.css_type_key]
    yield
    ENV[ConcordionEnvironment.output_dir_key] = orig_dir
    ENV[ConcordionEnvironment.css_type_key] = orig_type.to_s
  end
end
