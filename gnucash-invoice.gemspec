# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gnucash/invoice/version', __FILE__)


Gem::Specification.new do |gem|
  gem.name          = "gnucash-invoice"
  gem.version       = GnuCash::Invoice::VERSION
  gem.homepage      = "http://ixti.github.com/gnucash-invoice"
  gem.authors       = %w{Aleksey V Zapparov}
  gem.email         = %w{ixti@member.fsf.org}
  gem.summary       = "gnucash-invoice-#{GnuCash::Invoice::VERSION}"
  gem.description   = %q{GnuCash invoice printer for human beings.}

  gem.add_dependency "sequel",      "~> 3.41"
  gem.add_dependency "sprockets",   "~> 2.8"
  gem.add_dependency "slim",        "~> 1.3"

  gem.add_development_dependency "rake"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})

  gem.require_paths = ["lib"]
end
