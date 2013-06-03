class Employee < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :birthdate, :current_employee, :degree, :is_admin, :is_system_admin, :name, :nickname, :originate_end_date, :originate_start_date, :university, :years_prior_exp

  has_many :contracts, dependent: :nullify
  has_many :bonuses # , class_name: 'Bonus'

  default_scope order :id
  scope :current_employees, where(current_employee: true)

  def to_s
    nickname
  end
end

