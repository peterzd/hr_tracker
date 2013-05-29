module ControllerMacros
  def login_admin
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:employee]
      sign_in FactoryGirl.create(:employee, is_system_admin: true, nickname: 'sameer')
    end
  end

  def login_employee
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:employee]
      sign_in FactoryGirl.create(:employee, is_system_admin: false, nickname: 'peter')
    end
  end
end
