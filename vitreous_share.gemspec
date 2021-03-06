# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'vitreous/share/version'

Gem::Specification.new do |s|
  s.name        = 'vitreous_share'
  s.version     = Vitreous::Share::VERSION
  s.authors     = ['Fernando Guillen']
  s.email       = ['fguillen.mail@gmail.com']
  s.homepage    = 'https://github.com/fguillen/VitreousShare'
  s.summary     = 'Shared components for Vitreous'
  s.description = 'Shared components for Vitreous'

  s.rubyforge_project = 'vitreous_share'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
  
  s.add_dependency 'json'
  s.add_dependency 'dropbox'
  s.add_dependency 'mustache'
  s.add_dependency 'rdiscount'
  
  s.add_development_dependency 'bundler', '>= 1.0.0.rc.6'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'dummy_dropbox'
  s.add_development_dependency 'rake'
end
