require 'spec_helper'

describe Api::V1::ProductsController do
  describe '#index' do
    let!(:product) { create(:product) }

    it 'should render product' do

    end
  end

  describe '#show' do
    login_api_user
    let!(:comment) { create(:comment) }

    it 'should render product' do
      get :show, id: comment.product_id, format: :json
      expect(assigns(:product)).to eq(comment.product)
    end
  end
end