module Vitreous
  module Share
    class DropboxStructure < CommonStructure
      def initialize( path, session )
        @path     = path
        @session  = session
      end
      
      def generate( path = @path )
        {
          'name'     => File.basename( path ),
          'path'     => '/',
          'uri'      => "#{dropbox_base_uri}#{path.gsub( /^\/Public\//, '' )}",
          'type'     => 'directory',
          'elements' => tree( path ),
          'content'  => nil
        }
      end
      
      def tree( path )
        @session.entry( path ).list.to_a.map do |e|
          {
            'name'     => File.basename( e.path ),
            'path'     => e.path.gsub( @path, '' ),
            'uri'      => "#{dropbox_base_uri}#{path.gsub( /^\/Public\//, '' )}",
            'type'     => e.directory? ? 'directory' : 'file',
            'elements' => e.directory? ? tree( e.path ) : [],
            'content'  => CommonStructure.txt?( e.path ) ? @session.download( e.path ) : nil
          }
        end
      end
      
      def dropbox_base_uri
        "http://dl.dropbox.com/u/#{@session.account.uid}"
      end
    end
  end
end