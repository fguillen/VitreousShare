require File.expand_path( "#{File.dirname(__FILE__)}/test_helper" )

class DropboxStructureTest < Test::Unit::TestCase
  def setup
    DummyDropbox.root_path = FIXTURES_PATH
    @session_serialized = Dropbox::Session.new('key', 'secret').serialize
  end
  
  def test_generate
    structure =
      VitreousShare::DropboxStructure.new( 
        "/folder_structure",
        @session_serialized
      )
    
    result = structure.generate 
    
    assert( result.is_a? Array )
  end
  
  def test_json
    structure =
      VitreousShare::DropboxStructure.new( 
        "/folder_structure",
        @session_serialized
      )
      
    # # create fixture
    # File.open( "#{FIXTURES_PATH}/dropbox_structure.json", 'w' ) do |f|
    #   f.write structure.json
    # end
        
    assert_equal( 
      JSON.load( File.read( "#{FIXTURES_PATH}/dropbox_structure.json" ) ), 
      JSON.load( structure.json )
    )
  end
end