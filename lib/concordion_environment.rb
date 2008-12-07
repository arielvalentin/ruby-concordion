
class ConcordionEnvironment
  def self.clean_list
    File.join(output_dir, "*_test_output.html")
  end

  def self.output_dir
    dir = ENV['OUTPUT_DIR'] 
    dir.nil? ? "." : dir
  end
end
