module Vitreous
  module Share
    class LocalStructure < CommonStructure
    
      def initialize( path )
        @path = path
      end
      
      def generate( path = @path )
        {
          'name'     => File.basename( path ),
          'path'     => path == @path ? '/' : path.gsub( @path, '' ),
          'type'     => File.directory?( path ) ? 'directory' : 'file',
          'elements' => File.directory?( path ) ? tree( path ) : [],
          'content'  => CommonStructure.txt?( path ) ? File.read( path ) : nil
        }
      end
      
      def tree( path )
        Dir.glob( File.join( path, '*' ) ).sort.map do |e|
          generate( e ) 
        end
      end
    
    end
  end
end