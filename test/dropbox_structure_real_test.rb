# require File.expand_path( "#{File.dirname(__FILE__)}/test_helper" )
# 
# class DropboxStructureTest < Test::Unit::TestCase
#   def setup
#     @session = 
#       ::Dropbox::Session.deserialize(
#         File.read( "#{File.dirname(__FILE__)}/../tmp/session_authorized.serialized" )
#       )
#     
#     @session.mode = :dropbox
#   end
#   
#   def test_generate
#     structure =
#       Vitreous::Share::DropboxStructure.new( 
#         "/Public/Vitreous FAQ Spanish/website",
#         @session
#       )
#       
#     # create fixture
#     puts "!!This should be commented!!"
#     File.open( "#{FIXTURES_PATH}/dropbox_structure_real.json", 'w' ) do |f|
#       f.write JSON.pretty_generate structure.generate
#     end
#   end
# end