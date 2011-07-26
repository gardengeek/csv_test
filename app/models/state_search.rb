class StateSearch < ActiveRecord::Base
  require "date_conv"

  def self.columns() @columns ||= []; end

  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end

  column :state_id, :integer
  column :start_date, :date
  column :end_date, :date

  def start_date_str=(date_str)
    self[:start_date] = DateConv::string_to_date(date_str)
  end

  def start_date_str
    self[:start_date].to_s
  end

  def end_date_str=(date_str)
    self[:end_date] = DateConv::string_to_date(date_str)
  end

  def end_date_str
    self[:end_date].to_s
  end

  def self.default_summary_row(r)
    row = number_right_fixed(r.size, 5, '0')
    row += format_date_yyyymmdd(Date.today)
    row += format_left_fixed(nil, 10)
  end

  def self.default_row(r)
    row = format_left_fixed(r.first_name, 10)
    row += format_left_fixed(r.middle_name,5)
    row += format_left_fixed(r.last_name, 9)
    row += number_right_fixed(r.phone, 10, '0')
    row += format_date_yyyymmdd(r.birth_date)
  end

  def self.oh_row(r)
    row = Array.new
    row << "#{r.first_name} #{r.last_name}"
    row << r.birth_date.try(:to_s)
    row << r.age_at_create
  end

  def self.format_date_yyyymmdd(date)
    return(format_left_fixed(nil, 8)) if date.nil?
    "#{date.year}#{date.month.to_s.rjust(2,'0')}#{date.day.to_s.rjust(2,'0')}"
  end

  private
  def self.format_left_fixed(data, fixed_length, filler = ' ')
    data.to_s.ljust(fixed_length, filler)[0..(fixed_length - 1)]
  end

  def self.number_right_fixed(number, fixed_length, filler = ' ')
    number.to_s.gsub(/[^0-9]/,'')[0..(fixed_length - 1)].rjust(fixed_length, filler)
  end
end
