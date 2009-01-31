require 'test_helper'
require 'concordion_test_case'
require 'loader_helper'
class ImageTest < ConcordionTestCase
  include LoaderHelper
  def image_data
    File.read(path_for("image.jpg"))
  end
end
