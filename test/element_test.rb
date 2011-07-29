require File.expand_path( "#{File.dirname(__FILE__)}/test_helper" )

class ElementTest < Test::Unit::TestCase
  def test_initialize
    index = JSON.load( File.read( "#{FIXTURES_PATH}/index.json" ) )
    element = Vitreous::Share::Element.new( index )
    
    assert_equal( 'fixtures', element.title )
    assert_equal( '/', element.link )
    assert_equal( true, element.collection? )
    assert_equal( false, element.item? )
    assert_equal( 3, element.elements.size )
    assert_equal( 1, element.items.size )
    assert_equal( 2, element.collections.size )
    
    assert_equal( '/subfolder-1', element.elements.first.link )
  end
end
