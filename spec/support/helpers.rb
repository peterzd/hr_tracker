def helper_objects
  let(:sameer) { create :employee, is_system_admin: true, nickname: 'sameer' }
  let(:peter) { create :employee, is_system_admin: false, nickname: 'peter' }
  let(:allen) { create :employee, is_system_admin: false, nickname: 'allen' }
  let(:andy) { create :employee, is_system_admin: false, nickname: 'andy', current_employee: false }


  # About the bonuses
  let(:peter_bonus) { create(:bonus, amount: 1111, employee: peter) }
  let(:allen_bonus) { create(:bonus, amount: 2222, employee: allen) }
  let(:sameer_bonus) { create(:bonus, amount: 3333, employee: sameer) }

  # About the contracts
  let(:contract_sameer) { create(:contract, employee: sameer)}
  let(:contract_peter) { create(:contract, employee: peter)}
  let(:contract_peter_2) { create(:contract, employee: peter)}
  let(:contract_allen) { create(:contract, employee: allen) }
  let(:contract_andy) { create(:contract, employee: andy) }
end
