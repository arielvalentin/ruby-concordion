require 'loader_helper'

class ConcordionReader
  include LoaderHelper
  def read(filename)
    IO.read(path_for(filename))
  end


end
