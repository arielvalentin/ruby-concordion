

class ConcordionStringWriter
  attr_accessor :data
  def calculate_filename_and_overwrite(data, filename)
    @data = data.to_s
    filename
  end
  
  def output_file_exists?(filename)
    true
  end
end
