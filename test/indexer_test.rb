require File.expand_path( "#{File.dirname(__FILE__)}/test_helper" )

class IndexerTest < Test::Unit::TestCase
  def test_generate
    indexer = 
      Vitreous::Share::Indexer.new( 
        File.read( "#{FIXTURES_PATH}/structure.json" ) 
      )
    
    assert( indexer.generate.is_a? Array )
  end
  
  def test_json
    indexer = 
      Vitreous::Share::Indexer.new( 
        File.read( "#{FIXTURES_PATH}/structure.json" ) 
      )
      
    # # create fixture
    # File.open( "#{FIXTURES_PATH}/index.json", 'w' ) do |f|
    #   f.write indexer.json
    # end
    
    assert_equal( 
      JSON.load( File.read( "#{FIXTURES_PATH}/index.json" ) ), 
      JSON.load( indexer.json )
    )
  end
end