
require 'concordion_constants'
require 'concordion_string_utility'

module ConcordionConvenience
  def methods_for(clazz)
    (clazz.methods - Object.methods).sort 
  end
end

module ConcordionUtility
  include ConcordionConstants
  include ConcordionStringUtility
  include ConcordionConvenience


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
