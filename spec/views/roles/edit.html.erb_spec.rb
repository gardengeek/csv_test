require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/roles/edit.html.erb" do
  include RolesHelper

  before(:each) do
    @role = assign(:role, stub_model(Role,
      :title => "value for title"
    ))
  end

  it "renders the edit role form" do
    render

    rendered.should have_selector("form", :action => role_path(@role), :method => "post") do |form|
      form.should have_selector("input#role_title", :name => "role[title]")
    end
  end
end
