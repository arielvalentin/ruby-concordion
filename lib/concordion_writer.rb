class ConcordionWriter
  def write(data, filename)

    if File.exists?(filename)
      File.delete(filename)
    end
    f = File.new(filename, "w")
    f.puts data
    f.close

  end
  def calculate_filename_and_write(data, filename)
    outfile = output_filename_for(filename)
    write(data, outfile)

    outfile
  end

  def output_filename_for(name)
    name.sub(".html", "_test_output.html")
  end

end
