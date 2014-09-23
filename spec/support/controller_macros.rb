module ControllerMacros
  def login_api_user
    let(:current_user) { FactoryGirl.create(:user) }
    let(:token) { double :accessible? => true, resource_owner_id: current_user.id }

    before(:each) { controller.stub(:doorkeeper_token) { token } }
  end
end