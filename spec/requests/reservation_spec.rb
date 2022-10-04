require 'rails_helper'

RSpec.describe '/api/v1/reservation', type: :request do
  context 'Create Reservation ' do
    before(:each) do
      get api_v1_reservations_path, params: { authentication_token: User.first.authentication_token }
    end

    it 'List reservation as authorized user' do
      data = JSON.parse(response.body)
      expect(data['status']).to eq('Success')
    end

    it 'Create reservation as authorized user' do
      post api_v1_vehicle_reservations_path(Vehicle.first.id),
           params: { authentication_token: User.first.authentication_token, date: '24-09-2022', city: 'bravos' }
      data = JSON.parse(response.body)
      expect(data['status']).to eq('Success')
    end

    it 'Create reservation as invalid atrributs' do
      post api_v1_vehicle_reservations_path(Vehicle.first.id),
           params: { authentication_token: User.first.authentication_token, date: '24-09-2022' }
      data = JSON.parse(response.body)
      expect(data['status']).to eq('Failed')
    end
  end
  context 'Unauthorized access' do
    before(:each) do
      get api_v1_reservations_path
    end
    it 'Respnse unauthrozed' do
      expect(response.body).to include('You need to sign in or sign up before continuing')
    end
  end
end
