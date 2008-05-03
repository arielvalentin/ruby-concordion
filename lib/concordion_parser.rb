require 'rubygems'

require 'xmlsimple'
require 'hpricot'

class ConcordionParser
  @@ALL_ATTRIBUTED_ELEMENTS = "/html/body//*[@*]"
  @@TH_CSS_QUERY_REGEXP = /tr:nth\(\d+\) > th:nth\((\d+)\)$/
  @@TH_CSS_SINGLE_REGEXP = /tr:nth\(\d+\) > th$/
  @@ROW_REGEXP = /tr:nth\((\d+)\)/
  include ConcordionUtility

  attr_accessor :root, :body, :html

  def initialize(reader, concordion)
    @reader = reader
    @concordion = concordion
    @verifier = concordion.verifier
    @last_row = -1
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
        update_row(elem)
        if !look_for_headers(elem, attr)
          yield elem
        end
      end
    end
  end

  def update_row(elem)
    on_row = @@ROW_REGEXP.match(elem.css_path)
    if on_row
      current_row = on_row.captures[0]
      if current_row != @last_row
        @verifier.update_verifier(current_row.to_i)
        @last_row = current_row
      end
    else
      @last_row = -1
    end

  end

  def look_for_headers(elem, attr)
    header = @@TH_CSS_QUERY_REGEXP.match(elem.css_path)
    if header
      instrument_column(elem, attr, header.captures, @@TH_CSS_QUERY_REGEXP)
      return true
    end

    single_header = @@TH_CSS_SINGLE_REGEXP.match(elem.css_path)
    if single_header
      instrument_column(elem, attr, 0, @@TH_CSS_SINGLE_REGEXP)
      return true
    end

    false
  end

  def instrument_column(elem, attr, column_number, regex)
    trimmed = elem.css_path.sub(regex, '')
    td_css_query = trimmed + "tr > td:nth(#{column_number})"
    
    value = elem.get_attribute(attr)
    @root.search(td_css_query).set(attr, value)
  end


end
