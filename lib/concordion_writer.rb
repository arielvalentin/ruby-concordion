class ConcordionWriter
  @@DEFAULT = "."
  def initialize(output_dir = @@DEFAULT)
    @output_dir = output_dir.nil? ? @@DEFAULT : output_dir
  end

  def write(data, filename)
    f = File.new(filename, "w")
    f.puts data
    f.close
  end
  
  def output_file_exists?(filename)
    exists?(base_filename(filename))
  end
  
  def exists?(filename)
    File.exists?(filename)
  end
  
  def delete_if_exists(filename)
    if exists?(filename)
      File.delete(filename)
    end
    
  end
  
  def calculate_filename_and_overwrite(data, filename)
    outfile = output_filename_for(filename)
    delete_if_exists(outfile)
    write(data, outfile)

    outfile
  end

  def base_filename(filename)
    File.join(@output_dir, filename)
  end
  def output_filename_for(name)
    base_filename(name.sub(".html", "_test_output.html"))
  end

end
