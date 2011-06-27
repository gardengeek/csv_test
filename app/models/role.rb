class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
  validates_uniqueness_of :title, :case_sensitive => false
  validates_presence_of :title
  attr_accessible :title
end
