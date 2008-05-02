class BasicTextTest < ConcordionTestCase
  def set_name(name)
    @name = name
  end

  def double_down
    "#{@name*2}"
  end
end
