module Vitreous
  module Share
    module Render
      def self.render( opts )
        index   = Vitreous::Share::Element.new( opts[:index] )
        element = Vitreous::Share::IndexSearcher.search( index, opts[:resource] )
        status  = 200
        
        if element.nil?
          element = Vitreous::Share::IndexSearcher.not_found( index )
          status  = 404
        end
  
        Mustache.template_path = opts[:templates]
        
        body = 
          Mustache.render(
            File.read( "#{opts[:templates]}/layout.html" ),
            { 
              :index    => index, 
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