module Vitreous
  module Share
    module IndexerUtils
      def self.to_title( string )
        remove_digits( remove_extensions( string ) )
      end
      
      def self.remove_digits( string )
        string.gsub( /^\d*[_|\s]/, '' )
      end
      
      def self.remove_extensions( string )
        File.basename( string ).gsub( /\..*$/, '' )
      end
      
      def self.to_link( path )
        return path  if path == '/'
        
        path.split('/').map do |e| 
          to_slug( remove_extensions( e ) )
        end.join('/')
      end
      
      def self.full_path_to_slug( path )
        return ''  if path.empty?
        
        to_slug( remove_extensions( path.split('/').last ) )
      end
      
      def self.to_slug( string )
        to_title( string ).
          downcase.
          gsub(/[^a-z0-9 \-_]/,"").
          gsub('_', '-').
          gsub(/[ ]+/,"-")
      end
      
      def self.grouping( elements )
        elements.group_by do |e| 
          to_slug( e['name'] )
        end
      end
      
      def self.meta_properties( elements )
        result = {}
        
        elements.select { |e| e['type'] == 'file' }.each do |e|
          ext_name       = File.basename( e['path'] ).split( '.' )[-1]
          multi_ext_name = File.basename( e['path'] ).split( '.' )[1..-1].reverse.join( '_' )
          
          if( ext_name == 'meta' )
            result[multi_ext_name] = YAML.load( e['content'] )
            
          elsif( ext_name =~ Vitreous::TXT_EXTENSIONS )
            # wildcard
            result['description'] ||= e['content']
            result['descriptions'] ||= []
            result['descriptions'] << e['content']
            
            result[multi_ext_name] = e['content']
            
          else
            # wildcard
            result['file'] ||= e['uri']
            result['files'] ||= []
            result['files'] << e['uri']
            
            result[multi_ext_name] = e['uri']
          end
        end
        
        # create arrays of metas
        result.merge!( meta_arrays( result ) )
      end
      
      def self.meta_arrays( meta )
        result = {}
        
        meta.select { |k,v| !['meta', 'description', 'descriptions', 'file', 'files'].include? k }.each do |k,v|
          key = "#{k.split('_')[0]}s"
          result[key] ||= []
          result[key] << v
        end
        
        result.each do |k,v|
          result[k].sort!
        end
        
        return result
      end
    end
  end
end