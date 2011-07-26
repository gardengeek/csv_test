require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do
  include Devise::TestHelpers

  def mock_user(stubs={})
    stubs[:role_ids=] = []
    @mock_user ||= mock_model(User, stubs)
  end

  before(:each) do
    request.env['warden'] = mock(Warden, :authenticate => mock_user, :authenticate! => mock_user)
    mock_user.stub(:has_role?).with(:admin) {true}
  end

  describe "GET index" do
    it "assigns all users as @users" do
      User.stub!(:all).and_return([mock_user])
      get :index
      assigns[:users].should == [mock_user]
    end
  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      User.stub!(:find).with("37").and_return(mock_user)
      get :show, :id => "37"
      assigns[:user].should equal(mock_user)
    end
  end

  describe "GET edit" do
    it "assigns the requested user as @user" do
      User.stub!(:find).with("37").and_return(mock_user)
      get :edit, :id => "37"
      assigns[:user].should equal(mock_user)
    end
  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested user" do
        User.should_receive(:find).with("37").and_return(mock_user)
        mock_user.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :user => {:these => 'params'}
      end

      it "assigns the requested user as @user" do
        User.stub!(:find).and_return(mock_user(:update_attributes => true))
        put :update, :id => "1", :user => {:role_ids => []}
        assigns[:user].should equal(mock_user)
      end

      it "redirects to the user" do
        User.stub!(:find).and_return(mock_user(:update_attributes => true))
        put :update, :id => "1", :user => {:role_ids => []}
        response.should redirect_to(user_url(mock_user))
      end
    end

    describe "with invalid params" do
      it "updates the requested user" do
        User.should_receive(:find).with("37").and_return(mock_user)
        mock_user.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :user => {:these => 'params'}
      end

      it "assigns the user as @user" do
        User.stub!(:find).and_return(mock_user(:update_attributes => false))
        put :update, :id => "1", :user => {:these => 'params'}
        assigns[:user].should equal(mock_user)
      end

      it "re-renders the 'edit' template" do
        User.stub!(:find).and_return(mock_user(:update_attributes => false))
        put :update, :id => "1", :user => {:these => 'params'}
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested user" do
      User.should_receive(:find).with("37").and_return(mock_user)
      mock_user.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the users list" do
      User.stub!(:find).and_return(mock_user(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(users_url)
    end
  end

end
