
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
    name !~ /\(\)$/
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
  
end
