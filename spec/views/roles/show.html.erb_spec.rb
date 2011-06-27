require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/roles/show.html.erb" do
  include RolesHelper
  before(:each) do
    assign(:role, stub_model(Role,
      :title => "value for title"
    ))
  end

  it "renders attributes" do
    render
    rendered.should contain("value for title")
  end
end
