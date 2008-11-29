$: << File.join(File.expand_path(File.dirname( __FILE__)),"..","lib")
$: << File.join(File.expand_path(File.dirname( __FILE__)),"..","test-lib")
$: << File.expand_path(File.dirname( __FILE__))

require "test/unit"

class Test::Unit::TestCase

end
