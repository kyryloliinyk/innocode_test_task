# frozen_string_literal: true

module AppName
  class Application < Rails::Application
    # ....
    config.autoload_paths << Rails.root.join('lib/helpers')
  end
end
