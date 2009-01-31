# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 

module LoaderHelper
  def path_for(filename)
    return filename if File.exists?(filename)
    
    $LOAD_PATH.each do |path|
      candidate = "#{path}/#{filename}"
      return candidate if File.exists?(candidate)
    end
    throw Exception.new("could not find '#{filename}' on load path")
  end
end
