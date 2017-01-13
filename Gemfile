source ENV['GEM_SOURCE'] || 'https://rubygems.org'

puppetversion = ENV['PUPPET_VERSION'].nil? ? '~> 4.0' : ENV['PUPPET_VERSION'].to_s
gem 'puppet', puppetversion, require: false, groups: [:test]

if facterversion = ENV['FACTER_GEM_VERSION']
  gem 'facter', facterversion.to_s, :require => false, :groups => [:test]
else
  gem 'facter', :require => false, :groups => [:test]
end

group :test do
  gem 'puppetlabs_spec_helper', '~> 1.2.2',                         require: false
  gem 'rspec-puppet', '~> 2.5',                                     require: false
  gem 'rspec-puppet-utils',                                         require: false
  gem 'puppet-lint-absolute_classname-check',                       require: false
  gem 'puppet-lint-leading_zero-check',                             require: false
  gem 'puppet-lint-trailing_comma-check',                           require: false
  gem 'puppet-lint-version_comparison-check',                       require: false
  gem 'puppet-lint-classes_and_types_beginning_with_digits-check',  require: false
  gem 'puppet-lint-unquoted_string-check',                          require: false
  gem 'puppet-lint-variable_contains_upcase',                       require: false
  gem 'metadata-json-lint',                                         require: false
  gem 'puppet-blacksmith',                                          require: false
  gem 'puppet-strings', '~> 0.99.0',                                require: false
  gem 'rspec-puppet-facts',                                         require: false
  gem 'rubocop-rspec', '~> 1.6',                                    require: false if RUBY_VERSION >= '2.3.0'
  gem 'json_pure', '<= 2.0.1',                                      require: false if RUBY_VERSION < '2.0.0'
  gem 'mocha', '>= 1.2.1',                                          require: false
  gem 'coveralls',                                                  require: false if RUBY_VERSION >= '2.0.0'
  gem 'simplecov-console',                                          require: false if RUBY_VERSION >= '2.0.0'
  gem 'rubocop',                                                    require: false if RUBY_VERSION >= '2.0.0'
end

group :development do
  gem 'travis',       require: false
  gem 'travis-lint',  require: false
  gem 'guard-rake',   require: false
end

group :system_tests do
  gem 'beaker',                        require: false
  gem 'beaker-rspec',                  require: false
  gem 'serverspec',                    require: false
  gem 'beaker-puppet_install_helper',  require: false
end
