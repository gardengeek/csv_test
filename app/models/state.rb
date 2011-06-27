class State < ActiveRecord::Base
  validates_uniqueness_of :code, :name, :within => :country_code, :case_sensitive => false
  validates_presence_of :code, :name
  validates_inclusion_of :country_code, :in => %w{CA US MX}

  class << self
    def to_options
      State.find(:all, :conditions => {:country_code => 'US'}, :order => :code).collect {|s| [s.code + ' - ' + s.name, s.id]}
    end
  end
end
