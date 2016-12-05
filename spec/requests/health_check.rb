require 'rails_helper'

describe "HealthCheck API" do

    it 'responds to a check request' do
        get '/health_check/standard.json'
        json_body = JSON.parse(response.body)
        expect(response).to be_success
    end

    it 'returns a failure for an unknown check' do
        get '/health_check/unknown.json'
        json_body = JSON.parse(response.body)
        expect(response).to have_http_status(503)
    end
end
