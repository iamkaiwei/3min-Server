require 'spec_helper'

describe Api::V1::UsersController do
  login_api_user

  describe '#show' do
    let!(:user) { create(:user) }

    it 'should render product' do
      get :show, id: user.id, format: :json
      expect(assigns(:user)).to eq(user)
    end
  end
end