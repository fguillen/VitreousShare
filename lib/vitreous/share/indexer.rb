module Vitreous
  module Share
    class Indexer
      def initialize( structure )
        @structure = structure
      end
      
      def generate( structure = [@structure] )
        Vitreous::Share::IndexerUtils.grouping( structure ).values.map do |e|
          {
            'title'    => Vitreous::Share::IndexerUtils.file_name_to_title( e[0]['name'] ),
            'link'     => Vitreous::Share::IndexerUtils.to_link( e[0]['path'] ),
            'type'     => e.any? { |e2| e2['type'] == 'directory' } ? 'collection' : 'item',
            'elements' => generate( e[0]['elements'] )
          }.merge( Vitreous::Share::IndexerUtils.meta( e ) )
        end
      end
      
      def json
        JSON.pretty_generate( generate[0] )
      end
    end
  end
end