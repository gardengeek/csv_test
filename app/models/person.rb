class Person < ActiveRecord::Base

  belongs_to :state
  validates_presence_of :first_name, :last_name, :state_id


  def birth_date_str=(date_str)
    self[:birth_date] = DateConv::string_to_date(date_str)
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
end
