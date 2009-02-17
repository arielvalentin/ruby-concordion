# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'concordion_test_case'


class LinkStyleCssTest < ConcordionTestCase
  def expected_failure_count
    1
  end
  def css_type
    :link
  end
end
