require File.expand_path( "#{File.dirname(__FILE__)}/test_helper" )

class IndexSearcherTest < Test::Unit::TestCase
  def test_search
    index = JSON.load( File.read( "#{FIXTURES_PATH}/index.json" ) )
    
    element_found = 
      Vitreous::Share::IndexSearcher.search( 
        index['home'], 
        '/subfolder-1/subsubfolder-1/file-1'
      )

    assert_equal( 'file 1', element_found['title'] )
    assert_equal( '/subfolder-1/subsubfolder-1/file-1', element_found['link'] )    
  end
end