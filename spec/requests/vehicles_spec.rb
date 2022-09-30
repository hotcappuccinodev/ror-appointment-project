require 'rails_helper'

RSpec.describe '/api/v1/vehicles', type: :request do
  context 'Get vehicles ' do
    before(:each) do
      Rails.application.load_seed
      User.first.confirm
      get api_v1_vehicles_path,params:{authentication_token: User.first.authentication_token}
    end

    it 'List vehicles as authorized user' do
      data = JSON.parse(response.body)
      expect(data['status']).to eq('Success')
    end

    it 'List single vehicle' do
      get api_v1_vehicle_path(Vehicle.first.id),params:{authentication_token: User.first.authentication_token}
       data = JSON.parse(response.body)
      expect(data['message']).to eq('Loaded vehicle')
    end

    it 'List brand Vehicle' do
      get api_v1_vehicle_path(Vehicle.first.id),params:{authentication_token: User.first.authentication_token}
      data = JSON.parse(response.body)['data']['brand']
      expect(data).to eq(Vehicle.first.brand)
    end
    it 'Creates a vehicle' do
      post api_v1_vehicles_path, params:{authentication_token: User.first.authentication_token,brand: 'Mecedz', model: 'benz-30', image: 'image-bmw', price: 80, description: 'good and lightspeed with low consumptiom' }
      data = JSON.parse(response.body)
      expect(data['message']).to eq('Created Vehicle')
    end
     it 'Update a vehicle' do
      patch api_v1_vehicle_path(Vehicle.last.id), params:{authentication_token: User.first.authentication_token,brand: 'Lambo', model: 'lambo-30', image: 'image-bmw', price: 80, description: 'good and lightspeed with low consumptiom' }
      data = JSON.parse(response.body)
      expect(data['message']).to eq('Updeted Vehicle Succesfully')
    end

     it 'Deletes a vehicle' do
      delete api_v1_vehicle_path(Vehicle.last.id), params:{authentication_token: User.first.authentication_token }
      data = JSON.parse(response.body)
      expect(data['message']).to eq('Deleted Vehicle Succesfully')
    end
  end
  context 'Unauthorized access' do
     before(:each) do
      Rails.application.load_seed
      User.first.confirm
      get api_v1_vehicles_path
    end
        it 'Respnse unauthrozed' do
          expect(response.body).to include('You need to sign in or sign up before continuing')
        end
  end
end