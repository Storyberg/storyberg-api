Gem::Specification.new do |s|
  s.name        = 'storyberg'
  s.version     = '0.0.1'
  s.date        = '2013-01-14'
  s.summary     = "Hola!"
  s.description = "A simple hello world gem"
  s.authors     = ['Kevin Nguyen']
  s.email       = 'kevin@storyberg.com'
  s.files       = ['lib/storyberg.rb']
  s.homepage    =
    'http://rubygems.org/gems/storyberg'
  s.add_dependency('httparty')
  s.add_development_dependency "rspec", ">= 2.0.0"
end
