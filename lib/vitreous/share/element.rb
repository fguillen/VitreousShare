module Vitreous
  module Share
    class Element < Mustache
      def initialize( hash )
        @hash = hash
        meta_methods
      end
      
      def meta_methods
        @hash.each do |k,v|
          (class << self; self; end).class_eval do
            define_method( k.to_sym ) { v }  if !method_defined?( k.to_sym )
          end
        end
      end

      def home?
        @hash['link'] == '/'
      end
      
      def collection?
        @hash['type'] == 'collection'
      end

      def item?
        @hash['type'] == 'item'
      end

      def elements
        @hash['elements'].map { |e| Element.new( e ) }
      end

      def collections
        @hash['elements'].select { |e| e['type'] == 'collection' }.map { |e| Element.new( e ) }
      end

      def items
        @hash['elements'].select { |e| e['type'] == 'item' }.map { |e| Element.new( e ) }
      end
      
      def to_md( text )
        RDiscount.new( render( text ) ).to_html
      end
    end
  end
end
