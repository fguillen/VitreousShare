require File.expand_path( "#{File.dirname(__FILE__)}/test_helper" )

class DropboxStructureTest < Test::Unit::TestCase
  def setup
    DummyDropbox.root_path = FIXTURES_PATH
    @session = ::Dropbox::Session.new( 'key', 'secret' )
    @session.mode = :dropbox
  end
  
  def test_generate
    structure =
      Vitreous::Share::DropboxStructure.new( 
        "/folder_structure",
        @session
      )
      
    # # create fixture
    # File.open( "#{FIXTURES_PATH}/structure.json", 'w' ) do |f|
    #   f.write structure.json
    # end
        
    assert_equal( 
      JSON.load( File.read( "#{FIXTURES_PATH}/structure.json" ) ), 
      structure.generate
    )
  end
end