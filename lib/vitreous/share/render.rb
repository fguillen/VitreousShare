module Vitreous
  module Share
    module Render
      def self.render( opts )
        home    = Vitreous::Share::Element.new( opts[:index]['home'] )
        element = Vitreous::Share::IndexSearcher.search( home, opts[:resource] )
        status  = 200
        
        if element.nil?
          element = Vitreous::Share::Element.new( opts[:index]['not_found'] )
          status  = 404
        end
  
        Mustache.template_path = opts[:templates]
        
        body = 
          Mustache.render(
            File.read( "#{opts[:templates]}/layout.html" ),
            { 
              :home     => home, 
              :element  => element,
              :assets   => opts[:assets]
            }
          )
          
        OpenStruct.new(
          :status => status,
          :body   => body
        )
      end
    end
  end
end