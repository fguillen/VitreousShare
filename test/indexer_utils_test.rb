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
    
    assert_equal( 
      'pepe-y-jun', 
      Vitreous::Share::IndexerUtils.to_slug( '001 ¿pepe y juán?.txt' )
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
    
    assert_equal( 
      '/path-1/path-2/my-file', 
      Vitreous::Share::IndexerUtils.to_link( '/01 Path 1/01 Path 2/01 ¿My File?.thumb.jpg' )
    )
  end
  
  def test_grouping
    structure = JSON.load( File.read( "#{FIXTURES_PATH}/structure.json" ) )
    
    groups = Vitreous::Share::IndexerUtils.grouping( structure['elements'] )
    assert_equal( 3, groups.size )
  end
  
  def test_extension_properties
    meta = <<-EOS
      title: This is my new title
      collection: collection1
      price: 10
      summary: |
        This is a summary
        two lines long
    EOS
    
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
        "type"    => "file",
        "content" => meta,
        "path"    => "/folder 1.meta",
        "uri"     => "http://dropbox.com/user/folder 1.meta",
        "name"    => "folder 1.meta"
      },
      {
        "type"    => "directory",
        "content" => nil,
        "path"    => "/folder 1",
        "uri"     => "http://dropbox.com/user/folder 1",
        "name"    => "folder 1"
      }
    ]
    
    extension_properties = Vitreous::Share::IndexerUtils.extension_properties( structure )
    
    assert_equal( "http://dropbox.com/user/folder 1.jpg", extension_properties['jpg'] )
    assert_equal( "file content", extension_properties['txt'] )
    assert_equal( ["file content"], extension_properties['txts'] )
    assert_equal( ["http://dropbox.com/user/folder 1.jpg"], extension_properties['jpgs'] )

    # file/description
    assert_equal( "http://dropbox.com/user/folder 1.jpg", extension_properties['file'] )
    assert_equal( "file content", extension_properties['description'] )
    
    # meta
    assert_equal( "This is my new title", extension_properties['meta']['title'] )
    assert_equal( "collection1", extension_properties['meta']['collection'] )
    assert_equal( 10, extension_properties['meta']['price'] )
    assert_equal( "This is a summary\ntwo lines long\n", extension_properties['meta']['summary'] )
  end
  
  def test_extension_arrays
    extension_properties = {
      'jpg'   => 'jpg',
      'jpg_0' => 'jpg 0',
      'jpg_1' => 'jpg 1',
      'txt'   => 'txt',
      'txt_0' => 'txt 0'
    }

    extension_arrays = Vitreous::Share::IndexerUtils.extension_arrays( extension_properties )
        
    assert_equal( ["txt", "txt 0"], extension_arrays['txts'] )
    assert_equal( ["jpg", "jpg 0", "jpg 1"], extension_arrays['jpgs'] )
  end
end