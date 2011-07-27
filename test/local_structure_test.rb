require File.expand_path( "#{File.dirname(__FILE__)}/test_helper" )

class LocalStructureTest < Test::Unit::TestCase
  def test_generate
    structure =
      Vitreous::Share::LocalStructure.new( 
        "#{FIXTURES_PATH}/folder_structure" 
      )
    
    # # create fixture
    # puts "!!This should be commented!!"
    # File.open( "#{FIXTURES_PATH}/structure.json", 'w' ) do |f|
    #   f.write( JSON.pretty_generate( structure.generate ) )
    # end
        
    assert_equal( 
      JSON.load( File.read( "#{FIXTURES_PATH}/structure.json" ) ), 
      structure.generate
    )
  end
end