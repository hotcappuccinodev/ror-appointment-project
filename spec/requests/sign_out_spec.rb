require 'rails_helper'

RSpec.describe 'users/sign_in', type: :request do
  context 'sign-out existing session' do
    before() do
      Rails.application.load_seed
      User.first.confirm
      post user_session_path, params:{email: 'john@gmail.com',password: 'test123'}
      delete destroy_user_session_path
    end
     it 'Responds with ok status' do
      expect(response).to have_http_status(:ok)
     end

     it 'Responds data and has Success within the body' do
      expect(response.body).to include('Success')
     end
    it 'Responds data has email of the user signed out' do
      data = JSON.parse(response.body)['data']
      expect(data['email']).to eq('john@gmail.com')
     end 
 end

 context 'sign-out no session' do
  before() do
      delete destroy_user_session_path
    end
     it 'Responds with ok status' do
      expect(response).to have_http_status(:unauthorized)
     end
     it 'Responds data and has Success within the body' do
      expect(response.body).to include('Failed')
     end
    it 'Responds data has email of the user signed out' do
      data = JSON.parse(response.body)
      expect(data['message']).to eq('There is no user to sign out')
     end 
 end
end