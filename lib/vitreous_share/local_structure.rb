module VitreousShare
  class LocalStructure < CommonStructure
    
    def initialize( path )
      @path = path
    end
    
    def generate( path = @path )
      Dir.glob( File.join( path, '*' ) ).sort.map do |e|
        {
          :name     => File.basename( e ),
          :path     => e,
          :type     => File.directory?( e ) ? :directory : :file,
          :elements => File.directory?( e ) ? generate( e ) : [],
          :content  => CommonStructure.txt?( e ) ? File.read( e ) : nil
        }
      end
    end
    
  end
end