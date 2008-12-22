
class ConcordionLookaheadHandler


  def is_element_setter?(elem)
    !elem.get_attribute('concordion:set').nil?
  end

  def handle_lookahead(cpr, test_context, processor)
    cpr.tag.search("/*[@]").each {|child|
      if is_element_setter?(child)
        processor.process(child, test_context)
      end
    }
  end

end
