require 'spec_helper'

describe Api::V1::ProductsController do
  login_api_user

  render_views

  describe '#index' do
    let!(:product) { create(:product) }

    it 'should render product' do
      get :index, format: :json
      expect(assigns(:products)).to eq([product])
    end
  end

  describe '#show' do
    let!(:comment) { create(:comment) }

    it 'should render product' do
      get :show, id: comment.product_id, format: :json
      expect(assigns(:product)).to eq(comment.product)
    end
  end
end