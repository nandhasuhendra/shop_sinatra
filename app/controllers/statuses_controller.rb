# frozen_string_literal: true

class StatusesController < Sinatra::Base # :nodoc:
  set :views, "#{settings.root}/../views"

  before do
    content_type :json
  end

  get '/' do
    # env['warden'].authenticate!(:access_token)
    @body = request.body.read
    slim :'statuses/index'
  end
end
