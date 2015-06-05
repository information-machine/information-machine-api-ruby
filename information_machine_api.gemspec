Gem::Specification.new do |s|
  s.name        = 'information_machine_api'
  s.version     = '1.0'
  s.summary     = "information_machine_api"
  s.description = "Passively streamed purchase data. Infinitely smarter apps."
  s.authors     = ["Information Machine LLC", "Dejan Beric"]
  s.email       = 'dejan@iamdata.co'
  s.homepage    = 'http://www.iamdata.co'
  s.license     = 'MIT'

	s.add_dependency('unirest', '~> 1.1.2')

	s.required_ruby_version = '~> 2.0'

  s.files       = Dir['{bin,lib,man,test,spec}/**/*', 'README*', 'LICENSE*']  
  s.require_paths = ['lib']
  
end