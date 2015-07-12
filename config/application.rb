require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EatLunch
  class Application < Rails::Application

    config.browserify_rails.commandline_options = "--transform reactify "
    config.browserify_rails.commandline_options += "--transform coffee-reactify --extension=\".cjsx\" "
  end
end
