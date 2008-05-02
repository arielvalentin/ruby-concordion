
class SingleRowResult
  attr_accessor :alpha, :beta, :gamma
  def initialize(args)
    @alpha = args[0].upcase
    @beta = args[1].upcase
    @gamma = args[2].upcase
  end
end
