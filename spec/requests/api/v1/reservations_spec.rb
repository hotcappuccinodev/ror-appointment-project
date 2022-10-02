require 'swagger_helper'
# rubocop:disable Metrics/BlockLength
RSpec.describe 'session controller', type: :request do
  path '/api/v1/reservations' do
    get('List all reservations for the user') do
      tags 'Reservation index'
      description 'Shows all the reservations for the current user'
      consumes 'application/json'
      parameter name: :params, in: :query, schema: {
        type: :object,
        properties: {
          authentication_token: { type: :string }
        },
        required: %w[authentication_token]
      }

      response(200, 'successful') do
        @reservations = Reservation.where(user: User.find_by(email: 'john123@gmail.com'))
        let(:params) { { authentication_token: User.find_by(email: 'john123@gmail.com').authentication_token } }
        example 'application/json', :successfull_login, {
          status: 'Success',
          user: {
            id: 4,
            name: 'Jane Doe',
            email: 'jane123@gmail.com',
            created_at: '2022-10-01T22:01:18.257Z',
            updated_at: '2022-10-01T22:01:18.424Z',
            roles: [
              'admin'
            ],
            authentication_token: '2eTGmkNGx6HG7rp6S4zz'
          },
          data: [
            {
              id: 6,
              user_id: 4,
              vehicle_id: 4,
              date: '2022-09-24',
              city: 'capetown',
              created_at: '2022-10-01T22:01:18.563Z',
              updated_at: '2022-10-01T22:01:18.563Z'
            },
            {
              id: 7,
              user_id: 4,
              vehicle_id: 6,
              date: '2022-09-24',
              city: 'lusaka',
              created_at: '2022-10-01T22:01:18.568Z',
              updated_at: '2022-10-01T22:01:18.568Z'
            }
          ]
        }

        run_test!
      end
    end
  end

  path '/api/v1/vehicles/{vehicle_id}/reservations' do
    parameter name: 'vehicle_id', in: :path, type: :integer, description: 'vehicle id'
    post('create reservation') do
      tags 'Reservation create'
      description 'Creates a new reservation'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          authentication_token: { type: :string },
          city: { type: :string },
          date: { type: :string }
        },
        required: %w[authentication_token city date]
      }

      response(200, 'successful') do
        let(:vehicle_id) { Vehicle.last.id }
        let(:params) do
          { authentication_token: User.find_by(email: 'john123@gmail.com').authentication_token, city: 'London',
            date: '12/12/2021' }
        end
        example 'application/json', :successfull_create_reservation, {
          status: 'Success',
          message: 'created reservation',
          data: {
            id: 9,
            user_id: 4,
            vehicle_id: 6,
            date: '2022-10-02',
            city: 'bravos',
            created_at: '2022-10-01T22:21:11.569Z',
            updated_at: '2022-10-01T22:21:11.569Z'
          }
        }
        run_test!
      end

      response(401, 'unauthorized') do
        let(:vehicle_id) { Vehicle.last.id }
        let(:params) { { city: 'London', date: '12/12/2021' } }

        example 'application/json', :Failed_create_reservation, {
          status: 'Failed', message: 'Failed to create a new reservation'
        }
        run_test!
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
