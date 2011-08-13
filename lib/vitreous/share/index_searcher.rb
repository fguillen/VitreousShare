module Vitreous
  module Share
    class IndexSearcher
      def self.search( node, link )
        return node  if node['link'] == link

        node['elements'].each do |e|
          found = Vitreous::Share::IndexSearcher.search( e, link )
          return found  if found
        end

        return nil
      end
      
      def self.not_found( index )
        Vitreous::Share::Element.new( index.not_found )
      end
    end
  end
end
