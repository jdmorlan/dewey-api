require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'neo4j/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DeweyApi
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    Dir[Rails.root.join("config/routes/*.rb")].each do |file|
      config.paths["config/routes.rb"] << file
    end

    # Use Gzip to compress responses
    config.middleware.use Rack::Deflater

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
  end
end
