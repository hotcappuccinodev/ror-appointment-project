require 'swagger_helper'
# rubocop:disable Metrics/BlockLength

RSpec.describe 'api/v1/vehicles', type: :request do
  path '/api/v1/vehicles' do
    get('list vehicles') do
      tags 'vehicles', 'all'
      description 'List all vehicles'
      produces 'application/json'
      parameter name: :params, in: :query, schema: {
        type: :object,
        properties: {
          authentication_token: { type: :string }
        },
        required: %w[authentication_token]
      }
      response(200, 'successful') do
        let(:params) { { authentication_token: User.last.authentication_token } }
        example 'application/json', 'success', {
          status: 'Success',
          message: 'Loaded vehicles',
          data: [
            {
              id: 5,
              brand: 'Macendiz',
              model: 'Benz-30',
              price: '90.0',
              image: 'image-Benz',
              description: 'good and lightspeed with low consumptiom',
              created_at: '2022-10-01T04:51:07.296Z',
              updated_at: '2022-10-01T04:51:07.296Z'
            },
            {
              id: 6,
              brand: 'G-Wagon',
              model: 'G-wagon-15',
              price: '95.0',
              image: 'image-wagon',
              description: 'good and lightspeed with low consumptiom',
              created_at: '2022-10-01T04:51:07.302Z',
              updated_at: '2022-10-01T04:51:07.302Z'
            },
            {
              id: 7,
              brand: 'Farari',
              model: 'BMW',
              price: '450.0',
              image: 'farari.png',
              description: 'Some text here',
              created_at: '2022-10-01T12:39:00.705Z',
              updated_at: '2022-10-01T12:39:00.705Z'
            }
          ]
        }
        run_test!
      end

      response(401, 'unauthorized') do
        let(:params) { { authenticate_token: 'invalid toke' } }
        example 'application/json', 'unauthorized', {
          error: 'You need to sign in or sign up before continuing.'
        }
        run_test!
      end
    end
    post('create vehicle') do
      tags 'vehicle', 'create'
      consumes 'application/json'
      description 'Creates a vehicle'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          authentication_token: { type: :string },
          brand: { type: :string },
          model: { type: :string },
          image: { type: :string },
          price: { type: :decimal },
          description: { type: :text }
        },
        required: %w[authenticate_token brand model image price description]
      }
      response(200, 'successful') do
        let(:params) do
          { authentication_token: User.last.authentication_token,
            brand: 'Mecedz', model: 'benz-30', image: 'image-bmw',
            price: 80, description: 'good and lightspeed with low consumptiom' }
        end
        example 'application/json', 'success', {
          status: 'Success',
          message: 'Loaded vehicle',
          data: {
            id: 6,
            brand: 'G-Wagon',
            model: 'G-wagon-15',
            price: '95.0',
            image: 'image-wagon',
            description: 'good and lightspeed with low consumptiom',
            created_at: '2022-10-01T22:01:18.479Z',
            updated_at: '2022-10-01T22:01:18.479Z'
          }
        }
        run_test!
      end
    end
  end
  path '/api/v1/vehicles/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'vehicle id'
    get('show vehicle') do
      tags 'vehicle', 'single'
      consumes 'application/json'
      description 'Should retrieve single vehicle by id'
      parameter name: :params, in: :query, schema: {
        type: :object,
        properties: {
          authentication_token: { type: :string }
        },
        required: %w[authentication_token]
      }
      response(200, 'successful') do
        let(:id) { Vehicle.last.id }
        let(:params) { { authentication_token: User.first.authentication_token } }
        example 'application/json', 'success', {
          status: 'Success', message: 'Loaded vehicle',
          data: { id: 4, brand: 'BWM', model: 'BMW-30', price: '80.0',
                  image: 'image-bmw', description: 'good and lightspeed with low consumptiom',
                  created_at: '2022-10-01T04:51:07.286Z', updated_at: '2022-10-01T04:51:07.286Z' }
        }
        run_test!
      end
    end
    patch('update vehicle') do
      tags 'vehicle', 'update-patch'
      consumes 'application/json'
      description 'Should update single vehicle by id'
      parameter name: :params, in: :query, schema: {
        type: :object,
        properties: {
          authentication_token: { type: :string }
        },
        required: %w[authentication_token]
      }
      response(200, 'successful') do
        let(:id) { Vehicle.last.id }
        let(:params) do
          { authentication_token: User.first.authentication_token,
            brand: 'Lambo', model: 'lambo-30', image: 'image-bmw',
            price: 80, description: 'good and lightspeed with low consumptiom' }
        end
        example 'application/json', 'success', {
          status: 'Success', message: 'Loaded vehicle',
          data: { id: 4, brand: 'BWM', model: 'BMW-30', price: '80.0',
                  image: 'image-bmw', description: 'good and lightspeed with low consumptiom',
                  created_at: '2022-10-01T04:51:07.286Z', updated_at: '2022-10-01T04:51:07.286Z' }
        }
        run_test!
      end
    end
    put('update vehicle') do
      tags 'vehicle', 'update-put'
      consumes 'application/json'
      description 'Should update single vehicle by id'
      parameter name: :params, in: :query, schema: {
        type: :object,
        properties: {
          authentication_token: { type: :string }
        },
        required: %w[authentication_token]
      }
      response(200, 'successful') do
        let(:id) { Vehicle.last.id }
        let(:params) do
          { authentication_token: User.first.authentication_token,
            brand: 'Lambo', model: 'lambo-30', image: 'image-bmw',
            price: 80, description: 'good and lightspeed with low consumptiom' }
        end
        example 'application/json', 'success', {
          status: 'Success', message: 'Loaded vehicle',
          data: { id: 4, brand: 'BWM', model: 'BMW-30', price: '80.0',
                  image: 'image-bmw', description: 'good and lightspeed with low consumptiom',
                  created_at: '2022-10-01T04:51:07.286Z', updated_at: '2022-10-01T04:51:07.286Z' }
        }
        run_test!
      end
    end
    delete('delete vehicle') do
      tags 'vehicle', 'delete'
      consumes 'application/json'
      description 'Should delete single vehicle by id'
      parameter name: :params, in: :query, schema: {
        type: :object,
        properties: {
          authentication_token: { type: :string }
        },
        required: %w[authentication_token]
      }
      response(200, 'successful') do
        let(:id) { Vehicle.last.id }
        let(:params) { { authentication_token: User.first.authentication_token } }
        example 'application/json', 'success', {
          status: 'Success', message: 'Loaded vehicle',
          data: { id: 4,
                  brand: 'BWM', model: 'BMW-30', price: '80.0',
                  image: 'image-bmw', description: 'good and lightspeed with low consumptiom',
                  created_at: '2022-10-01T04:51:07.286Z', updated_at: '2022-10-01T04:51:07.286Z' }
        }
        run_test!
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
