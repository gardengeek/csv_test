class Person < ActiveRecord::Base

  belongs_to :state
  validates_presence_of :first_name, :last_name, :state_id


  def birth_date_str=(date_str)
    self[:birth_date] = DateConv::string_to_date(date_str)
  end

  def birth_date_str
    self[:birth_date].to_s
  end
end
