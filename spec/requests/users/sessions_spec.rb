require 'swagger_helper'

RSpec.describe 'session controller', type: :request do
  path '/users/sign_in' do
    post('create session') do
      tags 'Sign-in'
      description 'Authenticates an user and returns a jwt token'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response(200, 'successful') do
        @user = User.create!(name: 'User123', email: 'test١@test١.com', password: 'password', roles: ['user']) 
        @user.confirm
        let(:params) { { email: user.email, password: user.password } }
        example 'application/json', :successfull_login, {
          status: 'Success', message: 'signed in', data: @user
        }
        run_test!
      end

      response(401, 'unauthorized') do
        let(:params) { { email: 'test@test.com', password: 'password123' } }

        example 'application/json', :invalid_credentials, {
          status: 'failed', message: 'unauthorized'
        }
        run_test!
      end
    end
  end
end
