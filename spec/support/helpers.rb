def helper_objects 
  let(:sameer) { create :employee, is_system_admin: true, nickname: 'sameer' }
  let(:peter) { create :employee, is_system_admin: false, nickname: 'peter' }
end
