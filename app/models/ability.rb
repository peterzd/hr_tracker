class Ability
  include CanCan::Ability

  def initialize(employee)
    employee ||= Employee.new
    if (employee.is_system_admin? || employee.is_admin?)
      can :manage, :all
    elsif employee.persisted?
      can :manage, Employee do |managed_user|
        managed_user.id == employee.id
      end
      can :read, Contract do |managed_contract|
        managed_contract.employee.id == employee.id
      end
      can :read, Bonus do |managed_bonus|
        managed_bonus.employee.id == employee.id
      end
    end
  end
end
