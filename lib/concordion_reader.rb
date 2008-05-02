
class ConcordionReader
  def read(filename)
    IO.read(find_on_load_path(filename))
  end

  def find_on_load_path(filename)
    return filename if File.exists?(filename) 
    
    $LOAD_PATH.each {|path|
      candidate = "#{path}/#{filename}"
      return candidate if File.exists?(candidate)
    }

    raise "Could not find #{filename} on the system load path!"
  end

end
