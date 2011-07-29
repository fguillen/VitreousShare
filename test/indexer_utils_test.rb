# encoding: UTF-8
require File.expand_path( "#{File.dirname(__FILE__)}/test_helper" )

class IndexerUtilsTest < Test::Unit::TestCase

  def test_to_title
    assert_equal( 
      'Pepe y Juán', 
      Vitreous::Share::IndexerUtils.to_title( '001 Pepe y Juán.txt' )
    )
  end
  
  def test_to_slug
    assert_equal( 
      'pepe-y-jun', 
      Vitreous::Share::IndexerUtils.to_slug( '001 pepe y juán.txt' )
    )
  end
  
  def test_remove_extensions
    assert_equal( 
      '001 pepe y juán', 
      Vitreous::Share::IndexerUtils.remove_extensions( '001 pepe y juán.thumb.jpg' )
    )    
  end
  
  def test_to_link
    assert_equal( 
      '/path-1/path-2/my-file', 
      Vitreous::Share::IndexerUtils.to_link( '/01 Path 1/01 Path 2/01 My File.thumb.jpg' )
    )
    
    assert_equal( 
      '/', 
      Vitreous::Share::IndexerUtils.to_link( '/' )
    )
  end
  
  def test_grouping
    structure = JSON.load( File.read( "#{FIXTURES_PATH}/structure.json" ) )
    
    groups = Vitreous::Share::IndexerUtils.grouping( structure['elements'] )
    assert_equal( 3, groups.size )
  end
  
  def test_meta
    structure = [
      {
        "type"    => "file",
        "content" => nil,
        "path"    => "/folder 1.jpg",
        "uri"     => "http://dropbox.com/user/folder 1.jpg",
        "name"    => "folder 1.jpg"
      },
      {
        "type"    => "file",
        "content" => "file content",
        "path"    => "/folder 1.txt",
        "uri"     => "http://dropbox.com/user/folder 1.txt",
        "name"    => "folder 1.txt"
      },
      {
        "type"    => "directory",
        "content" => nil,
        "path"    => "/folder 1",
        "uri"     => "http://dropbox.com/user/folder 1",
        "name"    => "folder 1"
      }
    ]
    
    meta = Vitreous::Share::IndexerUtils.meta( structure )
    
    assert_equal( "http://dropbox.com/user/folder 1.jpg", meta['jpg'] )
    assert_equal( "file content",   meta['txt'] )
    assert_equal( ["file content"], meta['txts'] )
    assert_equal( ["http://dropbox.com/user/folder 1.jpg"], meta['jpgs'] )
  end
  
  def test_meta_arrays
    meta = {
      'jpg'       => 'jpg',
      'jpg_0'     => 'jpg 0',
      'jpg_1'     => 'jpg 1',
      'txt'       => 'txt',
      'txt_0'     => 'txt 0'
    }

    meta_arrays = Vitreous::Share::IndexerUtils.meta_arrays( meta )
        
    assert_equal( ["txt", "txt 0"], meta_arrays['txts'] )
    assert_equal( ["jpg", "jpg 0", "jpg 1"], meta_arrays['jpgs'] )
  end
end