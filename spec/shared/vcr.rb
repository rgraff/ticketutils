require 'vcr'

VCR.config do |config|
  config.cassette_library_dir = FIXTURE_ROOT
  config.default_cassette_options = { :record => :new_episodes }
  config.stub_with :webmock
end