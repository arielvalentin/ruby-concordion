
class ConcordionLookaheadHandler

  def is_element_setter?(elem)
    !elem.get_attribute('concordion:set').nil?
  end

  def handle_lookahead(cpr, test_context)
    if cpr.is_execute_command?
      cpr.tag.search("/*[@]").each {|child|
        if is_element_setter?(child)
          test_context.process(child)
        end
      }
    end
  end

end
