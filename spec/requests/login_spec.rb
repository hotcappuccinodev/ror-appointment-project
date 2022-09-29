require 'rails_helper'

RSpec.describe 'users/sign_in', type: :request do
  context 'sign' do
    before(:each) do
      post user_session_path, params:{email: 'jane@gmail.com',password: 'test123'}
    end
     it 'Responds with ok status' do
      puts response
      expect(response).to have_http_status(:ok)
     end

     it 'Responds data' do
      puts JSON.parse(response.body)['data']
      expect(response.body).to include('Success')
     end
    it 'Responds data email jane@gmail.com' do
       data = JSON.parse(response.body)['data']
      expect(data['email']).to eq('jane@gmail.com')
     end 
 end
end