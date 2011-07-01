class User < ActiveRecord::Base
  include Clearance::User
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable, :omniauthable, :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_and_belongs_to_many :roles
  belongs_to :country
  belongs_to :state

  attr_accessible :email,
    :first_name,
    :last_name,
    :password,
    :password_confirmation,
    :remember_me,
    :time_zone,
    :phone_number,
    :company_name,
    :title,
    :address_line_1,
    :address_line_2,
    :city,
    :state_id,
    :state_code,
    :postal_code,
    :country_id,
    :country_code

  validates_presence_of :first_name,
    :last_name,
    :phone_number,
    :company_name,
    :address_line_1,
    :city,
    :postal_code,
    :country_id

  validate :state_code_matches_country

  def state_code_matches_country
    allowed_values = self.country.try(:state_codes)

    if allowed_values.blank?
      errors.add(:state_id, "not permitted for #{self.country.try(:name)}") if state_id
    else
      errors.add(:state_id, "must be one of #{allowed_values.sort.join(" ")}") if !allowed_values.include?(self.state.try(:code))
    end
  end

  after_create :deliver_account_confirmation_instructions!

  def deliver_account_confirmation_instructions!
    generate_confirmation_token
    self.save!
    Notifier.account_confirmation_instructions(self).deliver
  end

  def deliver_password_reset_instructions!
    generate_confirmation_token
    self.save!
    Notifier.password_reset_instructions(self).deliver
  end

  def confirmed?
    self.confirmed_at
  end

  def has_role?(role)
    self.roles.map{|r| r.title}.include?(role.to_s)
  end

  def name
    "#{first_name} #{last_name}"
  end

  def cancel
    self.update_attribute(:active, false)
  end

  def country_code
    self.country.try(:code)
  end

  def country_code=(code)
    self.country = Country.find_by_code(code)
  end

  def state_code
    self.state.try(:code)
  end

  def state_code=(code)
    self.state = State.find_by_code(code)
  end
end
