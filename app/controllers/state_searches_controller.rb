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
                person = format_left_fixed(r.first_name, 10)
                person += format_left_fixed(r.middle_name,5)
                person += format_left_fixed(r.last_name, 9)
                person += number_fixed(r.phone, 10, '0')
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
    return(format_left_fixed(nil, 8)) if date.nil?
    "#{date.year}#{date.month.to_s.rjust(2,'0')}#{date.day.to_s.rjust(2,'0')}"
  end

  def format_left_fixed(data, fixed_length, filler = ' ')
    data.to_s.ljust(fixed_length, filler)[0..(fixed_length - 1)]
  end

  def number_fixed(number, fixed_length, filler = ' ')
    number.to_s.gsub(/[^0-9]/,'')[0..(fixed_length - 1)].rjust(fixed_length, filler)
  end
end
