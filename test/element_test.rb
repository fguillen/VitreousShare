require File.expand_path( "#{File.dirname(__FILE__)}/test_helper" )

class ElementTest < Test::Unit::TestCase
  def test_initialize
    index = JSON.load( File.read( "#{FIXTURES_PATH}/index.json" ) )
    home = Vitreous::Share::Element.new( index['home'] )
    
    assert_equal( 'fixtures', home.title )
    assert_equal( '/', home.link )
    assert_equal( true, home.collection? )
    assert_equal( false, home.item? )
    assert_equal( 3, home.elements.size )
    assert_equal( 1, home.items.size )
    assert_equal( 2, home.collections.size )
    
    assert_equal( '/subfolder-1', home.elements.first.link )
  end
  
  def test_render
    element_hash = {
      "title"     => "the title",
      "link"      => "the link",
      "jpg"       => "the jpg",
      "txt"       => "the txt"
    } 
    
    element = Vitreous::Share::Element.new( element_hash )
    
    result = 
      Mustache.render(
        "{{#element}}{{title}} | {{link}} | {{jpg}} | {{txt}}{{/element}}",
        { :element  => element }
      )
    
    assert_equal( 'the title | the link | the jpg | the txt', result )
  end
  
  def test_to_md
    element_hash = { "txt" => "Eo! MarkDown *rules*." } 
    element = Vitreous::Share::Element.new( element_hash )
    
    result = 
      Mustache.render(
        "{{#element}}{{#to_md}}{{txt}}{{/to_md}}{{/element}}",
        { :element  => element }
      )
      
    assert_equal( "<p>Eo! MarkDown <em>rules</em>.</p>\n", result )
  end
end
