require 'spec_helper'

describe StateSearchesController do
  include Devise::TestHelpers

  fixtures(:states)

  def mock_search(stubs={})
    @mock_search ||= mock_model(StateSearch, stubs).as_null_object
  end

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  before(:each) do
    request.env['warden'] = mock(Warden, :authenticate => mock_user, :authenticate! => mock_user)
    Factory.create(:person, :state => states(:states_54), :first_name => 'Betty', :last_name => 'Boop')
    Factory.create(:person, :state => states(:states_54), :first_name => 'Jack', :last_name => 'Benny', :birth_date => Date.parse('1950-10-15'), :created_at => Date.parse('2010-11-24'))
    Factory.create(:person, :state => states(:states_32), :first_name => 'Ginger',:last_name => 'Rogers', :birth_date => Date.parse('1980-09-20'))
    Factory.create(:person, :state => states(:states_32), :first_name => 'Mickey', :middle_name => 'Oconner', :last_name => 'Rooney', :birth_date => Date.parse('1960-09-02'), :phone => "(317)555-1212")
    Factory.create(:person, :state => states(:states_32), :first_name => 'Jack', :middle_name => 'A', :last_name => 'Benny', :phone => "(317)555-1212")
  end

  describe 'Get new' do
    it 'gets the state_search page' do
      StateSearch.stub(:new) {mock_search}
      get :new
      assigns(:search).should be(mock_search)
    end
  end

  describe 'create' do
    it 'creates a CSV file for Ohio (states_54)' do
      post :create, :state_search => { :state_id => states(:states_54), :start_date_str => '10312009', :end_date_str => Date.today}, :format => :csv
      response.headers['Content-Type'].should == 'text/csv; charset=utf-8'
      response.body.should == File.read("spec/files/state_search_result.csv")
    end  

    it 'creates a CSV file for Iowa (states_32)' do
      post :create, :state_search => { :state_id => states(:states_32), :start_date_str => '10312009', :end_date_str => Date.today}, :format => :csv
      response.headers['Content-Type'].should == 'text/csv; charset=utf-8'
      csv_result = File.read("spec/files/state_search_result2.csv")
      csv_result[5..12] = Format.date_yyyymmdd(Date.today)
      response.body.should == csv_result
    end  
  end
end  
