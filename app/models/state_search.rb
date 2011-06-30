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
end
