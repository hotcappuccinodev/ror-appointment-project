require 'swagger_helper'

RSpec.describe 'session controller', type: :request do
  path '/api/v1/reservations' do
    get('List all reservations for the user') do
      tags 'Reservation index'
      description 'Shows all the reservations for the current user'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          authentication_token: { type: :string }
        },
        required: %w[authentication_token]
      }

      response(200, 'successful') do
        @reservations = Reservation.where(user: User.last) 
        let(:params) { { authentication_token: User.last.authentication_token } }
        example 'application/json', :successfull_login, {
          status: 'Success', message: 'signed in', data: @reservations
        }
      
        run_test!
      end
    end
  end
  path '/api/v1/vehicles/{vehicle_id}/reservations' do
    post('create reservation') do
      tags 'Reservation create'
      description 'Creates a new reservation'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          authentication_token: { type: :string },          
          vehicle_id: { type: :integer },
          city: { type: :string },
          date: { type: :string }
        },
        required: %w[ authentication_token city date ]
      }

      response(200, 'successful') do
        let(:params) { { authentication_token: User.last.authentication_token, vehicle_id: Vehicle.first.id, city: 'London', date: '12/12/2021' } }
        example 'application/json', :successfull_create_reservation, {
          status: 'Success', message: 'created reservation', data: Reservation.last
        }
        run_test!
      end

      response(401, 'unauthorized') do
        let(:params) { { vehicle_id: Vehicle.first.id, city: 'London', date: '12/12/2021' } }

        example 'application/json', :Failed_create_reservation, {
          status: 'Failed', message: 'Failed to create a new reservation', data: @reservations
        }
        run_test!
      end
    end
  end
end
