
class ConcordionInstrumenter
  @@TH_CSS_QUERY_REGEXP = /tr:nth\(\d+\) > th:nth\((\d+)\)$/
  @@TH_CSS_SINGLE_REGEXP = /tr:nth\(\d+\) > th$/

  def instrument_from_headers(elem, attr, root)
    header = @@TH_CSS_QUERY_REGEXP.match(elem.css_path)
    if header
      instrument_column(elem, attr, header.captures, @@TH_CSS_QUERY_REGEXP, root)
      return true
    end

    single_header = @@TH_CSS_SINGLE_REGEXP.match(elem.css_path)
    if single_header
      instrument_column(elem, attr, 0, @@TH_CSS_SINGLE_REGEXP, root)
      return true
    end

    false
  end

  def instrument_column(elem, attr, column_number, regex, root)
    trimmed = elem.css_path.sub(regex, '')
    td_css_query = trimmed + "tr > td:nth(#{column_number})"
    
    value = elem.get_attribute(attr)
    root.search(td_css_query).set(attr, value)
  end

end
