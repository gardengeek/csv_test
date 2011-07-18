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
                row = Array.new
                row << "#{r.first_name} #{r.last_name}"
                row << r.birth_date.try(:to_s)
                row << r.age_at_create

                csv << row
              end
            else
              @results.each do |r|
                person = r.first_name.nil? ? ''.ljust(10) : r.first_name[0..9].ljust(10)
                person += r.middle_name.nil? ? ''.ljust(5) : r.middle_name[0..4].ljust(5)
                person += r.last_name.nil? ? ''.ljust(9) : r.last_name[0..8].ljust(9)
                person += r.phone.nil? ? ''.rjust(10,'0') : r.phone.gsub(/[^0-9]/,'')[0..9].rjust(10,'0')
                person += format_date_yyyymmdd(r.birth_date)

                csv << ["#{person}"]
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

  private
  def format_date_yyyymmdd(date)
    return(''.ljust(8)) if date.nil?
    "#{date.year}#{date.month.to_s.rjust(2,'0')}#{date.day.to_s.rjust(2,'0')}"
  end
end
