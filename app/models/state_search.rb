class StateSearch < ActiveRecord::Base
  require "date_conv"
  require "format"

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
    row = Format::number_right_fixed(r.size, 5, '0')
    row += Format::date_yyyymmdd(Date.today)
    row += Format::left_fixed(nil, 10)
  end

  def self.default_row(r)
    row = Format::left_fixed(r.first_name, 10)
    row += Format::left_fixed(r.middle_name,5)
    row += Format::left_fixed(r.last_name, 9)
    row += Format::number_right_fixed(r.phone, 10, '0')
    row += Format::date_yyyymmdd(r.birth_date)
  end

  def self.oh_row(r)
    row = Array.new
    row << "#{r.first_name} #{r.last_name}"
    row << r.birth_date.try(:to_s)
    row << r.age_at_create
  end
end
