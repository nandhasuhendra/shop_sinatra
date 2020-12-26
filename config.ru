# frozen_string_literal: true

require_relative './config/environment'
Dir.glob(File.join(__dir__, 'app', 'controllers', '*.rb')).each { |file| require file }

builder = Rack::Builder.new do
  use Rack::MethodOverride
  set :method_override, true

  use Rack::Session::Pool
  set :sessions, true

  set :root, File.dirname(__FILE__)
  set :slim, format: :html5, layout: :layout

  use Rack::Protection
  use Warden::Manager do |config|
    config.scope_defaults :default,
                          strategies: [:access_token],
                          action: 'session/unauthenticated'

    config.failure_app = self
  end

  Warden::Manager.before_failure do |env|
    env['REQUEST_METHOD'] = 'POST'
  end

  Warden::Strategies.add(:access_token) do
    def valid?
      request.env['HTTP_ACCESS_TOKEN'].is_a?(String)
    end

    def authenticate!
      access_granted = request.env['HTTP_ACCESS_TOKEN'] == ENV['API_KEY']

      access_granted ? success!(access_granted) : fail!('Could not log in')
    end
  end

  run Rack::URLMap.new({
                         '/session'      => SessionController,
                         '/api/notifies' => NotifiesController,
                         '/api/statuses' => StatusesController
                       })
end

run builder
