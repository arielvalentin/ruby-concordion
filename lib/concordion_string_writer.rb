

class ConcordionStringWriter
  attr_accessor :data
  def calculate_filename_and_write(data, filename)
    @data = data.to_s
    filename
  end
end
