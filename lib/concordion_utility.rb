
module ConcordionConstants

  def concordion_command_attributes
    [ "assertequals", "set", "execute", "verifyrows"].collect {|cmd| "concordion:#{cmd}"}
  end

  def supported?(tagname)
    ['p', 'span'].include?(tagname.downcase)
  end

end

module ConcordionStringUtility

  def has_arguments?(name)
    name !~ /\(\)$/
  end

  def concordion_assignment(name)
    name.split("=")[0].strip
  end

  def has_assignment?(name)
    name =~ /=/
  end

  def snake_case(str)
    s = str.gsub( /([A-Z])/, '_\1')
    if s.index("_") == 0
      s = s.slice(1, s.length)
    end

    s.downcase
  end

  def snake_cased_test_name(str)
    s = snake_case(str)
    s = s.gsub(/_test$/, '')
    "#{s}.html"
  end

  def snake_cased_goldmaster_name(str)
    snake_cased_test_name(str).gsub(".html", "_goldmaster.html")
  end

  def concordion_method_name(name)
    if name =~ /\(/
      base = name.split("(")[0].strip
    else
      base = name.strip
    end
    
    if !has_assignment?(base)
      return base
    end

    base.split("=")[1].strip
  end

  def singular(str)
    str.sub(/s$/, "")
  end

end
module ConcordionUtility
  include ConcordionConstants
  include ConcordionStringUtility

  def methods_for(clazz)
    (clazz.methods - Object.methods).sort 
  end

  def instrumentation(attr)
    attr.split(":")[1]
  end

  
  def supported_and_instrumented?(key)
    supported?(key) and instrumented?(key)
  end

  def concordion_arguments(name)
    return [] unless has_arguments?(name)
    name_no_end_paren = name.gsub(")", '')
    arg_string = name_no_end_paren.split("(")[1]

    arg_string.split(",").collect { |arg| arg.strip }
  end
  def concordion_variable_name(conc_call)
    if has_property_reference?(conc_call)
      return conc_call.split(".")[0].strip
    end

    conc_call.strip
  end

  def has_property_reference?(conc_call)
    conc_call =~ /\./
  end

  def concordion_property_reference(conc_call)
    if !has_property_reference?(conc_call)
      return conc_call
    end
    idx = conc_call.index(".")
    conc_call.slice(idx + 1, conc_call.length - idx).strip
  end



  def concordion_cmd_attr_exists?(elem)
    !concordion_cmd_attr_for(elem).nil?
  end

  def concordion_cmd_attr_for(elem)
    concordion_command_attributes.each {|attr| 
      instrumented_value = elem.get_attribute(attr)
      if !instrumented_value.nil?
        return attr
      end
    }
    
    nil
  end

end
