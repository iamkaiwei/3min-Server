require 'spec_helper'

describe Api::V1::CommentsController do
  describe '#index' do
    login_api_user
    let!(:comment) { create(:comment, user: current_user) }

    it 'should render comment' do
      get :index, product_id: comment.product_id, format: :json
      expect(assigns(:comments)).to match_array([comment])
    end
  end

  describe '#create' do
    login_api_user

    let!(:product) { create(:product) }

    it 'should create comment' do
      expect {
        post :create, format: :json, product_id: product.id, comment: { content: 'abc' }
      }.to change { Comment.count }.by 1
    end
  end

  describe '#update' do
    login_api_user

    let!(:comment) { create(:comment, user: current_user) }

    it 'should update comment' do
      put :update, format: :json, id: comment.id, comment: { content: 'changed' }
      expect(comment.reload.content).to eq('changed')
    end
  end

  describe '#destroy' do
    login_api_user

    let!(:comment) { create(:comment, user: current_user) }

    it 'should destroy comment' do
      expect {
        delete :destroy, format: :json, id: comment.id
        }.to change { Comment.count }.by -1
    end
  end
end