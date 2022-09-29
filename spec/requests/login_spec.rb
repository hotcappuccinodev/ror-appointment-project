require 'rails_helper'

RSpec.describe 'users/sign_in', type: :request do
  context 'sign' do
    let(:user) {User.create!(name: 'John Doe', email: 'john@gmail.com', password: 'test123', roles: ['admin'])}
    before(:each) do
      post user_session_path(user.email)
    end
     it 'Responds with ok status' do
      puts response
      expect(response).to have_http_status(:ok)
     end

     it 'Responds data' do
      puts response.body
      expect(response.body).to include('Success')
     end
 end
end