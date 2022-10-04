require 'swagger_helper'
# rubocop:disable Metrics/BlockLength
RSpec.describe 'session controller', type: :request do
  path '/users/sign_in' do
    post('create session') do
      tags 'Sign-in'
      description 'Authenticates an user and returns an authetication token'
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
        let(:params) { { email: 'jane123@gmail.com', password: 'test123' } }
        example 'application/json', :successfull_login, {
          status: 'Success',
          message: 'signed in',
          data: {
            id: 9,
            name: 'Jerrybrean',
            email: 'jerry6@gmail.com',
            created_at: '2022-10-02T00:14:02.059Z',
            updated_at: '2022-10-02T00:14:04.681Z',
            roles: [
              'user'
            ],
            authentication_token: 'rxorR4izaynzH3d_c_pn'
          }
        }
        run_test!
      end

      response(401, 'unauthorized') do
        let(:params) { { email: 'jane123@gmail.com', password: 'test12345' } }

        example 'application/json', :invalid_credentials, {
          status: 'failed', message: 'unauthorized'
        }
        run_test!
      end
    end
  end

  path '/users/sign_out' do
    delete('delete session') do
      tags 'Sign-out'
      description ' Signs out user in session'
      produces 'application/json'

      response(401, 'unauthorized') do
        example 'application/json', :unauthorized, {
          status: 'Failed',
          message: 'There is no user to sign out'
        }
        run_test!
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
