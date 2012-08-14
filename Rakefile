#!/usr/bin/env rake
require "bundler/gem_tasks"

begin
  # Set up load paths for all bundled gems
  ENV["BUNDLE_GEMFILE"] = File.expand_path("../Gemfile", __FILE__)
  Bundler.setup
rescue Bundler::GemNotFound
  raise RuntimeError, "Bundler couldn't find some gems." +
    "Did you run `bundle install`?"
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task :default => :spec

