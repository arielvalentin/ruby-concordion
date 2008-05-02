class ConcordionParseResult
  include ConcordionUtility
  attr_accessor :concordion_command, :system_under_test, :content
  def initialize(cmd, sut, content)
    @concordion_command = cmd
    @system_under_test = sut
    @content = content
  end
  def to_s
    "CPR: #{@concordion_command}, #{@system_under_test}, #{@content}"
  end

  def is_set_command?
    "set" == @concordion_command
  end
  def is_verify_command?
    "verifyrows" == @concordion_command
  end

  def assignment
    concordion_assignment(@system_under_test)
  end

  def needs_dereference?
    @system_under_test =~ /^#/ && @system_under_test.index("=").nil?
  end
end
