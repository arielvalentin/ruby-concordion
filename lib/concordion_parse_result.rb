require 'concordion_utility'

class ConcordionParseResult
  include ConcordionUtility
  attr_accessor :concordion_command, :system_under_test, :content, :tag
  def initialize(cmd, sut, content, tag)
    @concordion_command = cmd
    @system_under_test = sut
    @content = content
    @tag = tag
  end
  def to_s
    "Concordion command[#{@concordion_command}], System under test method[#{@system_under_test}], Tag Content[#{@content}] Image Location[#{image_location}]"
  end

  def is_assert_image_command?
    "assert_image" == @concordion_command
  end
  
  def is_set_command?
    "set" == @concordion_command
  end
  def is_verify_command?
    "verifyrows" == @concordion_command
  end
  def is_execute_command?
    "execute" == @concordion_command
  end
  def is_assert_true_command?
    "asserttrue" == @concordion_command
  end

  def num_results_expected
    @tag.search("tr").size - 1
  end
  
  def image_location
    return nil if @tag.nil?
    @tag.get_attribute('src')
  end
  
  def assignment
    concordion_assignment(@system_under_test)
  end

  def needs_dereference?
    @system_under_test =~ /^#/ && @system_under_test.index("=").nil?
  end

  def attribute_error(actual, expected)
      if is_verify_command?
        if actual > expected
        diff = actual - expected
        @tag.inner_html += "<tr><td>[#{diff} Surplus Row(s) Returned By Fixture]</td></tr>"
      end
    else
      if is_assert_true_command?
        @tag.inner_html += ": expected true but received #{actual}"
      else
        @tag.inner_html += " expected but received #{actual}"
      end
    end
  end
end
