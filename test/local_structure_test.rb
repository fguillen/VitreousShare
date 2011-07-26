require File.expand_path( "#{File.dirname(__FILE__)}/test_helper" )

class LocalStructureTest < Test::Unit::TestCase
  def test_generate
    structure =
      Vitreous::Share::LocalStructure.new( 
        "#{FIXTURES_PATH}/folder_structure" 
      )
    
    result = structure.generate 
    
    assert( result.is_a? Array )
  end
  
  def test_json
    structure =
      Vitreous::Share::LocalStructure.new( 
        "#{FIXTURES_PATH}/folder_structure" 
      )
    
    # # create fixture
    # File.open( "#{FIXTURES_PATH}/structure.json", 'w' ) do |f|
    #   f.write structure.json
    # end
        
    assert_equal( 
      JSON.load( File.read( "#{FIXTURES_PATH}/structure.json" ) ), 
      JSON.load( structure.json )
    )
  end
end