
class ReturnResultTest < ConcordionTestCase
  def split_name(name)
    ar = ArbitraryResult.new
    split = name.split(" ")
    ar.first = split[0]
    ar.last = split[1]

    ar
  end

  class ArbitraryResult
    attr_accessor :first, :last
  end
end
