require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")

describe "/users/edit.html.erb" do
  include UsersHelper

  before(:each) do
    @user = assign(:user, stub_model(User,
      :new_record? => false,
      :email => "value for email",
      :name => "value for name"
    ){|u| u.stub(:roles => []) })
  end

  it "renders the edit user form" do
    render

    rendered.should have_selector("form", :action => user_path(@user), :method => "post") do |form|
      form.should have_selector("input#user_email", :name => "user[email]")
      form.should have_selector("input#user_first_name", :name => "user[first_name]")
      form.should have_selector("input#user_last_name", :name => "user[last_name]")
    end
  end
end
