require 'rails_helper'

RSpec.describe 'users/', type: :request do
  context 'sign_up' do
    before(:each) do
      post user_registration_path, params:{email: 'basemshams300@yahoo.com', password: '12345678', name: "Bassem", roles: ['user']}
    end
     it 'Responds with ok status' do
      puts response
      expect(response).to have_http_status(:ok)
     end

     it 'Responds data' do
      puts JSON.parse(response.body)['data']
      expect(response.body).to include('Success')
     end
    it 'Responds data email basemshams300@yahoo.com' do
       data = JSON.parse(response.body)['data']
      expect(data['email']).to eq('basemshams300@yahoo.com')
     end 
 end
end