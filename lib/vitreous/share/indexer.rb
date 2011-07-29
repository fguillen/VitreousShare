module Vitreous
  module Share
    class Indexer
      def initialize( structure )
        @structure = structure
      end
      
      def generate( structure = [@structure] )
        Vitreous::Share::IndexerUtils.grouping( structure ).values.map do |e|
          {
            'title'    => Vitreous::Share::IndexerUtils.to_title( e[0]['name'] ),
            'link'     => Vitreous::Share::IndexerUtils.to_link( e[0]['path'] ),
            'type'     => e.any? { |e2| e2['type'] == 'directory' } ? 'collection' : 'item',
            'elements' => generate( e[0]['elements'].sort { |x, y| x['name'] <=> y['name'] } )
          }.merge( Vitreous::Share::IndexerUtils.meta( e ) )
        end
      end
      
      def json
        JSON.pretty_generate( generate[0] )
      end
    end
  end
end
