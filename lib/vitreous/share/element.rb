module Vitreous
  module Share
    class Elements < Mustache
      def initialize( element )
        @element = element
      end

      def collection?
        @element.type == 'collection'
      end

      def item?
        @element.type == 'item'
      end

      def elements
        @element['elements'].map { |e| Element.new( e ) }
      end

      def collections
        @element['elements'].select { |e| e.type == 'collection' }.map { |e| Element.new( e ) }
      end

      def items
        @element['elements'].select { |e| e.type == 'item' }.map { |e| Element.new( e ) }
      end
    end
  end
end
