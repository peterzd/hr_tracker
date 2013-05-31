def helper_objects
  let(:sameer) { create :employee, is_system_admin: true, nickname: 'sameer' }
  let(:peter) { create :employee, is_system_admin: false, nickname: 'peter' }
  let(:allen) { create :employee, is_system_admin: false, nickname: 'allen' }

  # About the bonuses
  let(:peter_bonus) { create(:bonus, amount: 1111, employee: peter) }
  let(:allen_bonus) { create(:bonus, amount: 2222, employee: allen) }
  let(:sameer_bonus) { create(:bonus, amount: 3333, employee: sameer) }
end
