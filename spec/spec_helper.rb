# frozen_string_literal: true

require "bundler/setup"
Bundler.setup

require "mundipagg_client"
require "faraday"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

require "vcr"
VCR.configure do |c|
  c.ingnore_localhost = true
  c.cassete_library_dir = "spec/cassetes"
  c.hook_into :webmock
  c.configure_rspec_metadata!
end
