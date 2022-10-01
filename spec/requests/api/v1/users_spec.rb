require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do
  path '/api/v1/users' do
    get('list all users') do
      tags 'Users index'
      description 'Shows all the users for the current user'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          authentication_token: { type: :string }
        },
        required: %w[authentication_token]
      }

      response(200, 'successful') do
        @users = User.all
        let(:params) { { authentication_token: User.last.authentication_token } }
        example 'application/json', :successfull_login, {
          status: 'Success', message: 'signed in', data: @users
        }
        run_test!
      end
    end
  end
end
