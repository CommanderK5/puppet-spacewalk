source 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? "#{ENV['PUPPET_VERSION']}" : ['>= 3.3']
gem 'puppet', puppetversion

gem 'facter', '>= 1.7.0'
gem 'rspec-puppet', '>= 2.2.0'
gem 'rspec-puppet-facts'
gem 'puppet-doc-lint'
gem 'puppet-lint'
gem 'puppetlabs_spec_helper'
gem 'puppet-syntax'

# Extra gems
gem 'rubocop', require: false
gem 'puppet-lint-appends-check', require: false
gem 'puppet-lint-version_comparison-check', require: false
gem 'puppet-lint-unquoted_string-check', require: false
gem 'puppet-lint-undef_in_function-check', require: false
gem 'puppet-lint-trailing_comma-check', require: false
gem 'puppet-lint-leading_zero-check', require: false
gem 'puppet-lint-file_ensure-check', require: false
gem 'puppet-lint-empty_string-check', require: false
