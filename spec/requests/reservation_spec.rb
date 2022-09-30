require 'rails_helper'

RSpec.describe '/api/v1/reservation', type: :request do
  context 'Create Reservation ' do
    before(:each) do
      Rails.application.load_seed
      User.first.confirm
      get api_v1_reservations_path,params:{authentication_token: User.first.authentication_token}
    end
  end
end