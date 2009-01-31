require 'test_helper'
require 'concordion_test_case'

class Thingit
  attr_reader :foo
  def initialize(foo)
    @foo = foo
  end
end

class VerifyRowsSimpleTest < ConcordionTestCase
  def getSearchResultsFor(query)
    users = []
    users << Thingit.new("bar")
    users
  end
end
