# Simplecov has to be the first thing in the spec_helper
# Otherwise it can't measure everything
require "simplecov"
SimpleCov.start do
  add_filter("/spec/")
end

require "bundler/setup"
require "webmock/rspec"

require "companion_cube"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
