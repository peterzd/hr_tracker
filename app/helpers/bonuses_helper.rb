module BonusesHelper
  def can_operate?
    operations = @operations.nil? ? true : @operations
    ( can? :manage, Bonus ) && operations
  end
end
