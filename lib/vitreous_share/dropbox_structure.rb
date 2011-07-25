module VitreousShare
  class DropboxStructure < CommonStructure
    def initialize( path, serialized_session )
      @path = path
      
      @session      = ::Dropbox::Session.deserialize( serialized_session )
      @session.mode = :dropbox
    end
    
    def generate( path = @path )
      @session.entry( path ).list.to_a.map do |e|
        {
          :name     => File.basename( e.path ),
          :path     => "#{dropbox_public_path}/#{e.path.gsub( /^\/Public\//, '' )}",
          :type     => e.directory? ? :directory : :file,
          :elements => e.directory? ? generate( e.path ) : [],
          :content  => CommonStructure.txt?( e.path ) ? @session.download( e.path ) : nil
        }
      end
    end
    
    private
    
    def dropbox_public_path
      "http://dl.dropbox.com/u/#{@session.account.uid}"
    end
  end
end