require 'concordion_css'

class ConcordionCSSDecorator
  def add_concordion_css_link(root, html)
    if html.at("head").nil?
      root.search("html").prepend('<head></head>')
    end

    html.search("head").append("<style type='text/css'>#{css}</style>")
  end

  def css
    ConcordionCSS.css_string
  end

  def decorate_tag(rv, tag) 
    if rv[:result]
      tag[:class] = 'concordion_success'
      return 0
    end

    tag[:class] = 'concordion_failure'
    tag.inner_html += " expected but received #{rv[:actual]}"
    1
  end
end
