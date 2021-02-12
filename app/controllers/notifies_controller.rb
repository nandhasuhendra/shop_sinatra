# frozen_string_literal: true

class NotifiesController < Sinatra::Base # :nodoc:
  before do
    content_type :json
  end

  post '/' do
    env['warden'].authenticate!(:access_token)

    puts request.body.read

    status 200
  end
end
