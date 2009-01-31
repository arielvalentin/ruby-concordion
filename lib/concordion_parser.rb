require 'rubygems'

require 'hpricot'
require 'concordion_instrumenter'

class ConcordionParser
  @@ALL_ATTRIBUTED_ELEMENTS = "/html/body//*[@*]"

  include ConcordionUtility

  attr_accessor :root, :body, :html

  def initialize(reader, concordion)
    @reader = reader
    @concordion = concordion
    @verifier = concordion.verifier
    @instrumenter = ConcordionInstrumenter.new
  end

  def parse(filename)
    @root = Hpricot.parse(@reader.read(filename))
    @body = @root.at("body")
    @html = @root.at("html")
  end
  def each_concordion_element(&block)
    @root.search(@@ALL_ATTRIBUTED_ELEMENTS).each {|elem|
      yield elem
    }
  end



  def each_eligible_concordion_element(&block)
    each_concordion_element do |elem|
      if concordion_cmd_attr_exists?(elem)       
        attr = concordion_cmd_attr_for(elem)
        @verifier.update_row(elem)
        if !@instrumenter.instrument_from_headers(elem, attr, @root)
          yield elem
        end
      end
    end
  end



end
