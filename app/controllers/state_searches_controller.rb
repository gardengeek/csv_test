class StateSearchesController < ApplicationController
  before_filter :authenticate_user!
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
      state ||= State.find(params[:state_search][:state_id])
      @results = Person.find(:all, :conditions => {:state_id => state.id}) #TODO: Replace find with actual search criteria

      if @results.empty?
        flash[:notice] = 'No people were found.'
        redirect_to new_state_search_path
      else
        respond_to do |format|

          format.csv {
            csv_data = FasterCSV.generate do |csv|
            if state.code == 'OH' 
              csv << ['Name','DOB','Age when added']
              @results.each do |r|
                csv << StateSearch::oh_row(r)
              end
            else
              @results.each do |r|
                csv << ["#{StateSearch::default_row(r)}"]
              end
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
