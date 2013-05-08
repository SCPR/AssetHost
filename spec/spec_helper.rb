ENV["RAILS_ENV"] ||= 'test'
require 'bundler/setup'

require 'combustion'
Combustion.initialize! :active_record, :action_controller, :action_view


require 'rspec/rails'
require 'factory_girl'
require 'fakeweb'
load 'factories.rb'

FakeWeb.allow_net_connect = false

Dir["support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  config.include FactoryGirl::Syntax::Methods

  config.before :each do
    # FakeWeb
  end
end
