require File.expand_path( "#{File.dirname(__FILE__)}/test_helper" )

class ElementSearcherTest < Test::Unit::TestCase
  def test_search
    root = JSON.load( File.read( "#{FIXTURES_PATH}/index.json" ) )
    
    element_found = 
      Vitreous::Share::ElementSearcher.search( 
        root, 
        '/subfolder-1/subsubfolder-1/file-1'
      )

    assert_equal( 'file 1', element_found['title'] )
    assert_equal( '/subfolder-1/subsubfolder-1/file-1', element_found['link'] )    
  end
  
  def test_search_not_found
    root = JSON.load( File.read( "#{FIXTURES_PATH}/index.json" ) )
    
    element_found = 
      Vitreous::Share::ElementSearcher.search( 
        root, 
        '/not/exists'
      )

    assert_nil( element_found )
  end
end