require 'spec_helper'

describe "people/index.html.erb" do
  fixtures(:states)
  before(:each) do
    assign(:people, [
      stub_model(Person,
        :first_name => "First Name",
        :last_name => "Last Name",
        :state_id => states(:states_17).id
      ),
      stub_model(Person,
        :first_name => "First Name",
        :last_name => "Last Name",
        :state_id => states(:states_17).id 
      )
    ])
  end

  it "renders a list of people" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "AZ".to_s, :count => 2
  end
end
