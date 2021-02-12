# frozen_string_literal: true

class SessionController < Sinatra::Base # :nodoc:
  before do
    content_type :json
  end

  post '/unauthenticated' do
    status 401
    content_type :json
    json(message: 'Sorry, this request can not be authenticated. Try again.')
  end
end
