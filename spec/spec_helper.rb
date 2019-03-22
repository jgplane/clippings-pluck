require "bundler/setup"
require "clippings_pluck"


RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  RSPEC_ROOT = File.dirname __FILE__
end
