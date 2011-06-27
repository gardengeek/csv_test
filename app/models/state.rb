class State < ActiveRecord::Base
  validates_uniqueness_of :code, :name, :within => :country_code, :case_sensitive => false
  validates_presence_of :code, :name
  validates_inclusion_of :country_code, :in => %w{CA US MX}
end
