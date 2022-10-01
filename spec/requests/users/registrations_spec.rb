require 'swagger_helper'

RSpec.describe 'regestration controller', type: :request do
  # rubocop:disable Metrics/BlockLength
  path '/users/' do
    post('create user') do
      tags 'Sign-up'
      description 'Creates a new user'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string },
          name: { type: :string },
          roles: { type: :array }
        },
        required: %w[email password password_confirmation name roles]
      }

      response(200, 'successful') do
        let(:params) { { email: 'user@email', password: '1234567', name: 'user', roles: ['admin'] } }
        example 'application/json', :successfull_signup, {
          status: 'Success', message: 'created users', data: User.find_by(email: User.last.email)
        }
        run_test!
      end

      response(401, 'unauthorized') do
        let(:params) { { email: 'test@test.com', password: 'password123' } }

        example 'application/json', :Failed_SignUp, {
          status: 500,
          message: 'Registration failed'
        }
        run_test!
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
