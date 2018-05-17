require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
# require "action_mailer/railtie"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

require "dotenv"
Dotenv.overload(".env.#{Rails.env}")

module AssetHost
  class Application < Rails::Application
    require "#{Rails.root}/lib/asset_host_core"
    require "#{Rails.root}/lib/asset_host_utils"
    # require "#{Rails.root}/lib/photographic_memory"
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.filter_parameters += [:password]

    # This is not referring to assets as in the asset model, but the
    # frontend resources like scripts, stylesheets, and other goodies.
    # Because we want a route called "assets" for our asset model, we
    # have to name this route prefix to something else.
    config.assets.prefix = "/resources"

    # initialize our config hash
    config.assethost = ActiveSupport::OrderedOptions.new

    config.elasticsearch_index = "assethost-assets"

    config.active_job.queue_adapter = :resque
    config.resque_queue             = ENV['ASSETHOST_RESQUE_QUEUE'] || :assets

    config.host_name     = ENV['ASSETHOST_HOST_NAME']     || 'localhost'
    config.host_port     = ENV['ASSETHOST_HOST_PORT']     || '3000'
    config.host_protocol = ENV['ASSETHOST_HOST_PROTOCOL'] || 'https'
    config.host          = "#{config.host_name}" + ((config.host_port == '80') ? "" : ":#{config.host_port}")
    ## ^^ This is necessary for URL generation.

    config.thumb_size           = "lsquare"
    config.modal_size           = "small"
    config.detail_size          = "eight"

    config.action_dispatch.default_headers.clear

    ENV["ELASTICSEARCH_URL"]  ||= Rails.application.secrets.elasticsearch['host']

  end
end
