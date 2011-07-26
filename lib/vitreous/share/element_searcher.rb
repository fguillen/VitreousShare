module Vitreous
  module Share
    class ElementSearcher
      def self.search( element, link )
        return element  if element['link'] == link

        element['elements'].each do |e|
          found = Vitreous::Share::ElementSearcher.search( e, link )
          return found  if found
        end

        return nil
      end
    end
  end
end
