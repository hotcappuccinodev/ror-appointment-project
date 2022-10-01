require 'swagger_helper'
# rubocop:disable Metrics/BlockLength

RSpec.describe 'api/v1/vehicles', type: :request do
  path '/api/v1/vehicles' do

    get('list vehicles') do
      tags 'vehicles','all'
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
          after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(401, 'unauthorized') do
        let(:params){{authenticate_token: 'invalid toke'}}
        example 'application/json', 'unauthorized', {
          error: 'You need to sign in or sign up before continuing.'
        }
        run_test!
      end
    end
  

    post('create vehicle') do
      tags 'vehicle','create'
      consumes 'application/json'
      description 'Creates a vehicle'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          authentication_token: {type: :string},
          brand: { type: :string},
          model: { type: :string },
          image: { type: :string },
          price: { type: :decimal },
          description: { type: :text }
        },
        required: ['authenticate_token','brand','model','image','price','description']
      }
      response(200, 'successful') do
        let(:params) {{ authentication_token: User.last.authentication_token,
                     brand: 'Mecedz', model: 'benz-30', image: 'image-bmw',
                     price: 80, description: 'good and lightspeed with low consumptiom' }}
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

   path '/api/v1/vehicles/{id}' do
     # You'll want to customize the parameter types...
     parameter name: 'id', in: :path, type: :string, description: 'vehicle id'
     get('show vehicle') do
      tags 'vehicle','single'
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
         let(:id) {Vehicle.last.id}
         let(:params) {{ authentication_token: User.first.authentication_token}}
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
    

     patch('update vehicle') do
      tags 'vehicle','update-patch'
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
         let(:id) {Vehicle.last.id}
         let(:params) {{ authentication_token: User.first.authentication_token,
                      brand: 'Lambo', model: 'lambo-30', image: 'image-bmw',
                      price: 80, description: 'good and lightspeed with low consumptiom' }}
         after do |example|
           example.metadata[:response][:content] = {
             'application/json' => {
               example: JSON.parse(response.body, symbolize_names: true)
             }
           }
           puts example.metadata[:response]
         end
         run_test!
       end
     end
  
     put('update vehicle') do
      tags 'vehicle','update-put'
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
         let(:id) {Vehicle.last.id}
         let(:params) {{ authentication_token: User.first.authentication_token,
                      brand: 'Lambo', model: 'lambo-30', image: 'image-bmw',
                      price: 80, description: 'good and lightspeed with low consumptiom' }}
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
    

     delete('delete vehicle') do
      tags 'vehicle','delete'
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
        let(:id) {Vehicle.last.id}
         let(:params) {{ authentication_token: User.first.authentication_token}} 
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
# rubocop:enable Metrics/BlockLength
