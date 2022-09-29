require 'swagger_helper'

RSpec.describe 'api/v1/reservations', type: :request do

  path '/api/v1/reservations' do

    get('list reservations') do
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/reservations/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show reservation') do
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/vehicles/{vehicle_id}/reservations' do
    # You'll want to customize the parameter types...
    parameter name: 'vehicle_id', in: :path, type: :string, description: 'vehicle_id'

    post('create reservation') do
      response(200, 'successful') do
        let(:vehicle_id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/vehicles/{vehicle_id}/reservations/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'vehicle_id', in: :path, type: :string, description: 'vehicle_id'
    parameter name: 'id', in: :path, type: :string, description: 'id'

    delete('delete reservation') do
      response(200, 'successful') do
        let(:vehicle_id) { '123' }
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
