# frozen_string_literal: true

class NotifiesController < Sinatra::Base # :nodoc:
  before do
    content_type :json
  end

  get '/' do
    env['warden'].authenticate!(:access_token)
    json(message: 'Notifies Controller')
  end
end
