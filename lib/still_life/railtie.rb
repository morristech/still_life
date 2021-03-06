# frozen_string_literal: true

require 'rails'

module StillLife
  class Railtie < Rails::Railtie
    initializer 'still_life' do
      if ENV['STILL_LIFE'] || ENV['STILLLIFE']
        ActiveSupport.on_load :action_dispatch_integration_test do
          ActionDispatch::Integration::Session.prepend StillLife::ActionDispatchExtension
        end
        ActiveSupport.on_load :action_dispatch_system_test_case do
          ActionDispatch::SystemTestCase.include StillLife::CapybaraExtension
        end

        begin
          require 'rspec-rails'

          #TODO maybe we could use some kind of hook instead of directly configuring here?
          RSpec.configure do |config|
            # config.prepend StillLife::ActionDispatchExtension, type: :request
            config.prepend StillLife::ActionDispatchExtension, type: :controller
            config.include StillLife::CapybaraExtension, type: :feature
          end
        rescue LoadError
        end
      end
    end
  end
end
