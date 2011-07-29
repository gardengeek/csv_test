class Person < ActiveRecord::Base

  require "date_conv"

  belongs_to :state
  validates_presence_of :first_name, :last_name, :state_id
  attr_accessible :first_name, :last_name, :middle_name, :state_id, :state, :phone, :birth_date_str
  attr_accessor :birth_date_valid


  validate :validate_date


  def birth_date_str=(date_str)
    dob = DateConv::string_to_date(date_str)
    if dob == false 
      self.birth_date_valid = "Invalid date"
    else
      self[:birth_date] = dob
      self.birth_date_valid = ""
    end
  end

  def birth_date_str
    self[:birth_date].to_s
  end

  def age
    return('') if self.birth_date.nil?
    age = Date.today.year - self.birth_date.year
    age -= 1 if Date.today < (self.birth_date + age.years)
    age
  end

  def age_at_create
    return('') if self.birth_date.nil?
    age = self.created_at.year - self.birth_date.year
    age -= 1 if self.created_at < (self.birth_date + age.years)
    age
  end

  def validate_date
    errors.add(:birth_date_str, "is invalid") unless self.birth_date_valid.blank? 
  end
end
