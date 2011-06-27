require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/roles/index.html.erb" do
  include RolesHelper

  before(:each) do
    assign(:roles, [
      stub_model(Role,
        :title => "value for title"
      ),
      stub_model(Role,
        :title => "value for title"
      )
    ])
  end

  it "renders a list of roles" do
    render
    rendered.should have_selector("tr>td", :content => "value for title".to_s, :count => 2)
  end
end
