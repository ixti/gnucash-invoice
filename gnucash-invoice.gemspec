# -*- encoding: utf-8 -*-
require File.expand_path("../lib/gnucash/invoice/version", __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "gnucash-invoice"
  gem.version       = GnuCash::Invoice::VERSION
  gem.homepage      = "http://ixti.github.com/gnucash-invoice"
  gem.authors       = ["Aleksey V Zapparov"]
  gem.email         = ["ixti@member.fsf.org"]
  gem.summary       = "gnucash-invoice-#{GnuCash::Invoice::VERSION}"
  gem.description   = "GnuCash invoice printer for human beings."

  gem.add_dependency "date",        "~> 1.0.0"
  gem.add_dependency "mysql2",      "~> 0.5.2"
  gem.add_dependency "sequel",      "~> 3.41"
  gem.add_dependency "slim",        "~> 1.3"
  gem.add_dependency "sass",        "~> 3.2"
  gem.add_dependency "sprockets",   "~> 2.8"

  gem.add_development_dependency "sqlite3"
  gem.add_development_dependency "rake"

  gem.files         = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  gem.executables   = gem.files.grep(/^bin\//).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(/^(test|spec|features)\//)

  gem.require_paths = ["lib"]
end
