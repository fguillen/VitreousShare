require File.expand_path( "#{File.dirname(__FILE__)}/test_helper" )
require 'dummy_dropbox'

class DropboxStructureTest < Test::Unit::TestCase
  def setup
    DummyDropbox.root_path = File.dirname(__FILE__)
    @session = ::Dropbox::Session.new( 'key', 'secret' )
    
    # @session = 
    #   ::Dropbox::Session.deserialize(
    #     File.read( "#{File.dirname(__FILE__)}/tmp/session_authorized.serialized" )
    #   )
    
    @session.mode = :dropbox
  end
  
  def test_generate
    Vitreous::Share::DropboxStructure.any_instance.stubs( :uri ).returns( 'wadus uri' )
    
    structure =
      Vitreous::Share::DropboxStructure.new( 
        "/fixtures/folder_structure",
        @session
      )
      
    # # create fixture
    # puts "!!This should be commented!!"
    # File.open( "#{FIXTURES_PATH}/structure.json", 'w' ) do |f|
    #   f.write JSON.pretty_generate structure.generate
    # end
        
    assert_equal( 
      JSON.load( File.read( "#{FIXTURES_PATH}/structure.json" ) ), 
      structure.generate
    )
  end
end