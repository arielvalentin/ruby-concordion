require 'test_helper'
require 'concordion_test_case'

class VerifyRowsTest < ConcordionTestCase
  def setup
    @users = []
  end

  def setupUser(name, other)
    @users << User.new(name,other)
  end

  def getSearchResultsFor(query)
    @users.select {|u| u.name.include?(query) }.sort{|x,y| x.name <=> y.name}
  end
end
