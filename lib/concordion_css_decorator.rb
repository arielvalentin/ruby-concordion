require 'concordion_css'
require 'concordion_error_condition'

class ConcordionCSSDecorator
  def add_concordion_css_link(root, html, type)
    if html.at("head").nil?
      root.search("html").prepend('<head></head>')
    end
    #TODO add an environment variable for this?
    if type == :link
      link_to_css(html)
    else
      inline_css(html)
    end
  end
  
  def append_to_head(html, s)
    html.search("head").append(s)
  end
  def link_to_css(html)
    append_to_head(html, "<link rel='stylesheet' type='text/css' href='#{css_filename}' />")
  end
  
    
  def inline_css(html)
    append_to_head(html, "<style type='text/css'>#{css}</style>")
  end
  
  def css
    ConcordionCSS.css_string
  end
  
  def css_filename
    ConcordionCSS.css_filename
  end

  def add_css_file_to_output_dir(writer, type)
    if !writer.output_file_exists?(css_filename) && type == :link
      writer.calculate_filename_and_overwrite(css, css_filename)
    end
  end
  
  def decorate_tag(rv, tag) 
    context = tag.to_html
    expected = tag.inner_html
    xpath = tag.xpath
    
    if rv[:result]
      tag[:class] = 'concordion_success'
      return nil
    end

    tag[:class] = 'concordion_failure'
    tag.inner_html += " expected but received #{rv[:actual]}"
    
    ConcordionErrorCondition.new(expected, rv[:actual], xpath, context)
  end
end
