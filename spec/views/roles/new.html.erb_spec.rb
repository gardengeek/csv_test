require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/roles/new.html.erb" do
  include RolesHelper

  before(:each) do
    assign(:role, stub_model(Role,
      :title => "value for title"
    ).as_new_record)
  end

  it "renders new role form" do
    render

    rendered.should have_selector("form", :action => roles_path, :method => "post") do |form|
      form.should have_selector("input#role_title", :name => "role[title]")
    end
  end
end
