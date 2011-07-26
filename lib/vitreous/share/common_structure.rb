module Vitreous
  module Share
    class CommonStructure
      def self.txt?( path )
        File.extname( path ).gsub( '.', '' ) =~ Vitreous::TXT_EXTENSIONS
      end
    end
  end
end