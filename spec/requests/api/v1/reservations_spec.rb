require 'swagger_helper'

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
        
        @reservations = Reservation.where(user: User.find_by(email:  'john123@gmail.com'))
        let(:params) { { authentication_token: User.find_by(email:  'john123@gmail.com').authentication_token } }
        example 'application/json', :successfull_login, {
          status: 'Success', message: 'signed in', data: @reservations
        }

        run_test!
      end
    end
  end
  # rubocop:disable Metrics/BlockLength
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
          { authentication_token: User.find_by(email:  'john123@gmail.com').authentication_token, city: 'London',
            date: '12/12/2021' }
        end
        example 'application/json', :successfull_create_reservation, {
          status: 'Success', message: 'created reservation', data: Reservation.last
        }
        run_test!
      end

      response(401, 'unauthorized') do
        let(:vehicle_id) { Vehicle.last.id }
        let(:params) { { city: 'London', date: '12/12/2021' } }

        example 'application/json', :Failed_create_reservation, {
          status: 'Failed', message: 'Failed to create a new reservation', data: @reservations
        }
        run_test!
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
