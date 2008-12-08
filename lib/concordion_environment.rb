
class ConcordionEnvironment
  def self.output_dir_key
    'RCOR_OUTPUT_DIR'
  end
  
  def self.clean_list
    File.join(output_dir, "*_test_output.html")
  end

  def self.output_dir
    dir = ENV[output_dir_key] 
    dir.nil? ? "." : dir
  end
end
