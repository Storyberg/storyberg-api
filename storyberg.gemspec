Gem::Specification.new do |s|
  s.name        = 'storyberg'
  s.version     = '1.0.0'
  s.date        = '2013-01-14'
  s.summary     = "Storyberg is a project management tool that helps business owners make better decisions."
  s.description = "Identify accounts and users then, track user events with Storyberg."
  s.authors     = ['Kevin Nguyen']
  s.email       = 'kevin@storyberg.com'
  s.files       = ['lib/storyberg.rb']
  s.homepage    =
    'http://rubygems.org/gems/storyberg'
  s.add_dependency('httparty')
  s.add_development_dependency "rspec", ">= 2.0.0"
end
