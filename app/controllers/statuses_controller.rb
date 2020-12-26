# frozen_string_literal: true

class StatusesController < Sinatra::Base # :nodoc:
  before do
    content_type :json
  end

  get '/' do
    env['warden'].authenticate!(:access_token)
    json(message: 'Statuses Controller')
  end
end
