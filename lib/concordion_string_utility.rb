
module SnakeCaseUtility
  
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
  
end

module PluralToSingularUtility
  
  def singular(str)
    str.sub(/s$/, "")
  end
end

module ConcordionStringUtility
  include SnakeCaseUtility
  include PluralToSingularUtility
  
  def has_arguments?(name)
    !(ends_in_empty_parens?(name) || is_direct_method_call?(name))
  end

  def is_direct_method_call?(name)
    name =~ /^[\w]+$/
  end
  
  def ends_in_empty_parens?(name)
    name =~ /\(\)$/
  end
  
  def concordion_assignment(name)
    name.split("=")[0].strip
  end

  def has_assignment?(name)
    name =~ /=/
  end

  def attr_writer_method?(name)
    name =~ /=$/
  end
  
  def concordion_method_name(name)
    if name =~ /\(/
      base = name.split("(")[0].strip
    else
      
      
      base = name.strip
      if base =~ /\s/
        
        if base =~ /=/ && base =~ /^#/
          base = base.split("=")[1].strip
        end
        elements = base.split(/\s/)
        base = elements[0]
      end
    end
    
    if !has_assignment?(base)
      return base
    end
 
    if attr_writer_method?(base)
      return base if base.count("=") == 1
      return assignment(base) + "="
    end
    
    assignment(base)
  end

  def assignment(base)
    base.split("=")[1].strip
  end
  
  def escape_single_quotes(s)
    s.gsub(/[']/, '\\\\\\\\\'')
  end

end
