require 'pathname'
require 'rubygems'
require 'rspec'
require 'vcr'
require 'ticketutils'

SPEC_ROOT    = Pathname(__FILE__).dirname.expand_path
LIB_ROOT     = SPEC_ROOT.parent + 'lib'
FIXTURE_ROOT = SPEC_ROOT.join('fixtures')

# Requires supporting files with custom matchers and macros, etc.,
# in ./support/ and its subdirectories.
Dir[File.expand_path('../shared/**/*.rb', __FILE__)].each do |file|
  require(file)
end

RSpec.configure do |config|
  config.mock_with :rspec
  config.extend VCR::RSpec::Macros
  
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end