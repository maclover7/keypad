$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require "keypad/version"

Gem::Specification.new do |s|
  s.name = "keypad"
  s.version = Keypad::VERSION
  s.authors = "Jon Moss"
  s.email = "me@jonathanmoss.me"
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ["lib"]
  s.homepage = "http://github.com/maclover7/keypad"
  s.licenses = "MIT"
  s.summary = "Easy OmniAuth Authentication with Ruby on Rails"

  s.add_dependency "omniauth"
  s.add_dependency "omniauth-oauth2"
  s.add_dependency "rails"
  s.add_development_dependency "bundler"
  s.add_development_dependency "pry"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end
