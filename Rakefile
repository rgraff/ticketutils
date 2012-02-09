require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "ticketutils"
    gem.summary = %Q{TicketUtils.com client using their API}
    gem.description = %Q{TicketUtils.com client for using thier API}
    gem.email = "spike@ticketevolution.com"
    gem.homepage = "http://github.com/ticketevolution/ticketutils"
    gem.authors = ["Spike Grobstein", "Adam Fortuna"]

    gem.add_development_dependency 'rspec'
    gem.add_development_dependency 'vcr', '~> 1.10'
    gem.add_development_dependency 'rcov'
    
    gem.add_dependency "httparty"
    gem.add_dependency "will_paginate"
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:spec) do |test|
  test.libs << 'lib' << 'spec'
  test.pattern = 'spec/**/*_spec.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'spec'
    test.pattern = 'spec/**/*_spec.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies
task :default => :spec