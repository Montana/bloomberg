# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "bloomberg/version"

Gem::Specification.new do |s|
  s.name        = "bloomberg"
  s.version     = Bloomberg::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Montana Mendy"]
  s.email       = ["montana@montanamendy.com"]
  s.homepage    = "http://github.com/montana"
  s.summary     = %q{Fetch a company list from Bloomberg LP, save it to a CSV using OAuth.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
