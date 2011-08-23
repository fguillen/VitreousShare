require File.expand_path( "#{File.dirname(__FILE__)}/test_helper" )

class IndexerTest < Test::Unit::TestCase
  def test_render_collection
    index = JSON.load( File.read( "#{FIXTURES_PATH}/index.json" ) )
    result = 
      Vitreous::Share::Render.render(
        :resource  => '/subfolder-1',
        :index     => index,
        :assets    => '/assets_path',
        :templates => "#{FIXTURES_PATH}/template"
      )
    
    # # write fixture
    # puts "This should be commented out!"
    # File.open( "#{FIXTURES_PATH}/render_collection.txt", 'w' ) do |f|
    #   f.write result.body
    # end
    
    assert_equal( 200, result.status )
    assert_equal( File.read( "#{FIXTURES_PATH}/render_collection.txt" ), result.body )
  end
  
  def test_render_item
    index = JSON.load( File.read( "#{FIXTURES_PATH}/index.json" ) )
    result = 
      Vitreous::Share::Render.render(
        :resource  => '/subfolder-1/subsubfolder-1/file-1',
        :index     => index,
        :assets    => '/assets_path',
        :templates => "#{FIXTURES_PATH}/template"
      )
    
    # # write fixture
    # puts "This should be commented out!"
    # File.open( "#{FIXTURES_PATH}/render_item.txt", 'w' ) do |f|
    #   f.write result.body
    # end
    
    assert_equal( 200, result.status )
    assert_equal( File.read( "#{FIXTURES_PATH}/render_item.txt" ), result.body )
  end
  
  def test_render_home
    index = JSON.load( File.read( "#{FIXTURES_PATH}/index.json" ) )
    result = 
      Vitreous::Share::Render.render(
        :resource  => '/',
        :index     => index,
        :assets    => '/assets_path',
        :templates => "#{FIXTURES_PATH}/template"
      )
    
    # write fixture
    puts "This should be commented out!"
    File.open( "#{FIXTURES_PATH}/render_home.txt", 'w' ) do |f|
      f.write result.body
    end
    
    assert_equal( 200, result.status )
    assert_equal( File.read( "#{FIXTURES_PATH}/render_home.txt" ), result.body )
  end
  
  def test_render_not_found
    index = JSON.load( File.read( "#{FIXTURES_PATH}/index.json" ) )
    result = 
      Vitreous::Share::Render.render(
        :resource  => '/wadus/not/found',
        :index     => index,
        :assets    => '/assets_path',
        :templates => "#{FIXTURES_PATH}/template"
      )
    
    # # write fixture
    # puts "This should be commented out!"
    # File.open( "#{FIXTURES_PATH}/render_not_found.txt", 'w' ) do |f|
    #   f.write result.body
    # end
    
    assert_equal( 404, result.status )
    assert_equal( File.read( "#{FIXTURES_PATH}/render_not_found.txt" ), result.body )
  end
end