
class ProcessesElementsInSortedOrderTest < ConcordionTestCase

  def setup
    @next_value = 0
  end
  def next
    @next_value += 1
    @next_value.to_s
  end
end
