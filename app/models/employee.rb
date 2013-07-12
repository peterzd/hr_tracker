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

  class << self
    # returns the hash of [employee, days]
    def high_priority
      employees_with_expired.select { |employee, days| days < 50 }
    end

    def medium_priority
      employees_with_expired.select { |employee, days| (days >= 50) && (days < 90) }
    end

    def low_priority
      employees_with_expired.select { |employee, days| days >= 90 }
    end

    private
    def employees_with_expired
      expired_employees = {}
      Employee.all.each do |e|
        contract = e.contracts.last
        expired_employees[e] = (contract.end_date - Date.today).to_i unless contract.nil?
      end

      expired_employees
    end
  end


  def to_s
    nickname
  end
end

