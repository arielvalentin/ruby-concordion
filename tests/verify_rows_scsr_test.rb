
class VerifyRowsScsrTest < ConcordionTestCase 
  def setup
    @users = []
  end

  def setupUser(name)
    @users << User.new(name,"whatever")
  end

  def getSearchResultsFor(query)
    @users.select {|u| u.name.include?(query) }.sort{|x,y| x.name <=> y.name}
  end

end
