
class TableTest < ConcordionTestCase 
  def split_by_colons(text)
    SingleRowResult.new(text.split(":"))
  end
end

