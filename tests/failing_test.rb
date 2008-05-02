class FailingTest < ConcordionTestCase

  def initialize(suite)
    super(suite, {:expected_failure_count => 1})
  end

  def wrong_value
    "wrong"
  end

end

