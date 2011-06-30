class StateSearchesController < ApplicationController
  before_filter :authorize
  load_and_authorize_resource

  require 'fastercsv'

  def new
    @search = StateSearch.new
  end

  def create
    if params[:state_search][:state_id].blank? ||
       params[:state_search][:start_date_str].blank? ||
       params[:state_search][:end_date_str].blank?

      flash[:notice] = 'State, starting date and ending date must all have values.'
      redirect_to new_state_search_path
    else
      @results = Person.find(:all, :conditions => {:state_id => params[:state_search][:state_id]}) #TODO: Replace find with actual search criteria

      if @results.empty?
        flash[:notice] = 'No people were found.'
        redirect_to new_state_search_path
      else
        respond_to do |format|

          format.csv {
            csv_data = FasterCSV.generate do |csv|
              csv << ['Name', 'DOB']
              @results.each do |r|
                row = Array.new
                row << "#{r.first_name} #{r.last_name}"
                row << r.birth_date.try(:to_s)

                csv << row
              end
            end

            csv = csv_data.to_s
            render :text => csv
          }
        end
      end
    end
  end
end
