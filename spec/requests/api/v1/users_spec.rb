require 'swagger_helper'
# rubocop:disable Metrics/BlockLength
RSpec.describe 'api/v1/users', type: :request do
  path '/api/v1/users' do
    get('list all users') do
      tags 'Users index'
      description 'Shows all the users for the current user'
      consumes 'application/json'
      parameter name: :params, in: :query, schema: {
        type: :object,
        properties: {
          authentication_token: { type: :string }
        },
        required: %w[authentication_token]
      }

      response(200, 'successful') do
        let(:params) { { authentication_token: User.last.authentication_token } }
        example 'application/json', :successfull_login, {
          status: 'Success',
          message: 'Loaded users',
          data: [
            {
              id: 3,
              name: 'John Doe',
              email: 'john123@gmail.com',
              created_at: '2022-10-01T22:01:17.342Z',
              updated_at: '2022-10-01T22:01:18.420Z',
              roles: [
                'admin'
              ],
              authentication_token: 'h1HWsdfRxFHziZB69Vre'
            },
            {
              id: 4,
              name: 'Jane Doe',
              email: 'jane123@gmail.com',
              created_at: '2022-10-01T22:01:18.257Z',
              updated_at: '2022-10-01T22:01:18.424Z',
              roles: [
                'admin'
              ],
              authentication_token: '2eTGmkNGx6HG7rp6S4zz'
            }
          ]
        }
        run_test!
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
