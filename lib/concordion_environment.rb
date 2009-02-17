
class ConcordionEnvironment
  def self.output_dir_key
    'RCOR_OUTPUT_DIR'
  end
  
  def self.css_type_key
    'RCOR_CSS_TYPE'
  end
  
  def self.with_dir(str)
    File.join(output_dir, str)
  end
  def self.clean_list
    [with_dir("*_test_output.html"), with_dir("concordion.css")] #TODO is this safe to delete? what if the user overwrites this file?
  end

  def self.css_type
    type = ENV[css_type_key] 
    type.nil? ? :inline : type.to_sym
  end
  
  def self.output_dir
    dir = ENV[output_dir_key] 
    dir.nil? ? "." : dir
  end
end
