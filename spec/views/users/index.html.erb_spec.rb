require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/index.html.erb" do
  include UsersHelper

  before(:each) do
    assign(:users, [
      stub_model(User,
        :email => "value for email",
        :name => "value for name"
      ){|u| u.stub(:roles => []) },
      stub_model(User,
        :email => "value for email",
        :name => "value for name"
      ){|u| u.stub(:roles => []) }
    ])
  end

  it "renders a list of users" do
    render
    rendered.should have_selector "tr>td", :content => "value for name".to_s, :count => 2
    rendered.should have_selector "tr>td", :content => "value for email".to_s, :count => 2
  end
end
