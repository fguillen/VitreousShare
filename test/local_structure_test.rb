require File.expand_path( "#{File.dirname(__FILE__)}/test_helper" )

class LocalStructureTest < Test::Unit::TestCase
  def test_generate
    structure =
      VitreousShare::LocalStructure.new( 
        "#{FIXTURES_PATH}/folder_structure" 
      )
    
    result = structure.generate 
    
    assert( result.is_a? Array )
  end
  
  def test_json
    structure =
      VitreousShare::LocalStructure.new( 
        "#{FIXTURES_PATH}/folder_structure" 
      )
    
    # # create fixture
    # File.open( "#{FIXTURES_PATH}/local_structure.json", 'w' ) do |f|
    #   f.write structure.json
    # end
        
    assert_equal( 
      JSON.load( File.read( "#{FIXTURES_PATH}/local_structure.json" ) ), 
      JSON.load( structure.json )
    )
  end
end