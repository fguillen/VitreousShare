module VitreousShare
  class CommonStructure
    TXT_EXTENSIONS = /^(txt|md|html|meta)$/ 
    
    def json
      JSON.pretty_generate( generate )
    end
    
    def self.txt?( path )
      File.extname( path ).gsub( '.', '' ) =~ TXT_EXTENSIONS
    end
  end
end