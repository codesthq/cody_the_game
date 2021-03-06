require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module CodyOnRails
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true

    config.autoload_paths += ["#{Rails.root}/tasks", "#{Rails.root}/services"]

    config.generators do |g|
      g.test_framework nil
    end
  end
end
