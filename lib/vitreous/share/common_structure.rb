module Vitreous
  module Share
    class CommonStructure
      def json
        JSON.pretty_generate( generate )
      end
    
      def self.txt?( path )
        File.extname( path ).gsub( '.', '' ) =~ Vitreous::TXT_EXTENSIONS
      end
    end
  end
end