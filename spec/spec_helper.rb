require 'bundler/setup'
require 'healthy_rack'

require 'rack/test'

Dir['./spec/shared_examples/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.include Rack::Test::Methods

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  def json_body
    JSON.parse(session.last_response.body)
  end

  def http_status
    session.last_response.status
  end
end
