require 'rails_helper'

RSpec.describe 'accounts', type: :request do
  it do
    post '/accounts'

    expect(response).to have_http_status(:created)
    expect(response.body).to be_json_including({
      token: String
    })
  end
end
