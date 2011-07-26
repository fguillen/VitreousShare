module Vitreous
  module Share
    class DropboxStructure < CommonStructure
      def initialize( path, session )
        @path = path
        @session = session
      end
    
      def generate( path = @path )
        element = @session.entry( path )
        
        {
          'name'     => File.basename( element.path ),
          'path'     => path == @path ? '/' : element.path.gsub( @path, '' ).gsub( /^\/Public\//, '' ),
          'type'     => element.metadata.directory? ? 'directory' : 'file',
          'elements' => element.metadata.directory? ? tree( element ) : [],
          'content'  => CommonStructure.txt?( element.path ) ? @session.download( element.path ) : nil
        }
      end
      
      def tree( element )
        element.list.to_a.map do |e|
          generate( e.path )
        end
      end
    end
  end
end