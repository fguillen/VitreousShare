require File.expand_path( "#{File.dirname(__FILE__)}/test_helper" )
require 'dummy_dropbox'

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
    # puts "!!This should be commented!!"
    # File.open( "#{FIXTURES_PATH}/dropbox_structure.json", 'w' ) do |f|
    #   f.write JSON.pretty_generate structure.generate
    # end
        
    assert_equal( 
      JSON.load( File.read( "#{FIXTURES_PATH}/dropbox_structure.json" ) ), 
      structure.generate
    )
  end
end