module Vitreous
  module Share
    class Indexer
      def initialize( structure )
        @structure = structure
      end
      
      def generate
        structure = @structure
        
        {
          'home'      => generate_home( structure ),
          'not_found' => generate_not_found( structure )
        }
      end
        
      def generate_home( structure )
        {
          'title'     => Vitreous::Share::IndexerUtils.to_title( structure['name'] ),
          'link'      => '/',
          'slug'      => '',
          'type'      => 'home',
          'elements'  => tree( structure['elements'].select { |e| !(e['name'] =~ /^_/) }.sort { |x, y| x['name'] <=> y['name'] } )
        }.merge( 
          Vitreous::Share::IndexerUtils.meta_properties(
            structure['elements'].select { |e| e['name'] =~ /^_home\./ } 
          )
        )
      end
      
      def generate_not_found( structure )
        {
          'title'       => 'Not found',
          'type'        => 'not_found',
          'slug'        => 'not_found',
          'elements'    => [],
        }.merge( 
          Vitreous::Share::IndexerUtils.meta_properties(
            structure['elements'].select { |e| e['name'] =~ /^_not_found\./ } 
          )
        )
      end
      
      def tree( structure )
        Vitreous::Share::IndexerUtils.grouping( structure ).values.map do |e|
          {
            'title'    => Vitreous::Share::IndexerUtils.to_title( e[0]['name'] ),
            'link'     => Vitreous::Share::IndexerUtils.to_link( e[0]['path'] ),
            'slug'     => Vitreous::Share::IndexerUtils.to_slug( e[0]['path'] ),
            'type'     => e.any? { |e2| e2['type'] == 'directory' } ? 'collection' : 'item',
            'elements' => tree( e[0]['elements'].sort { |x, y| x['name'] <=> y['name'] } )
          }.merge( Vitreous::Share::IndexerUtils.meta_properties( e ) )
        end
      end
            
      def json
        JSON.pretty_generate( generate )
      end
    end
  end
end
