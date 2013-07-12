require 'spec_helper'

describe EmployeesController do
  helper_objects

  before :each do
    Employee.delete_all
  end

  describe "GET index" do
    before :each do
      [sameer, peter, allen, andy].each(&:save)
    end

    let(:request) { get :index }
    let(:assigns_assertion) { assigns[:employees].count == Employee.current_employees.count }
    let(:page_behavior) { render_template 'index' }
    it_should_behave_like "access by the admin", '@employees'
    it_should_behave_like "access by the normal employee", "@employees"
  end

  describe "GET show" do
    let(:request) { get :show, id: peter.id }
    let(:page_behavior) { render_template 'show' }
    it_should_behave_like "access by the admin"
    it_should_behave_like "access by the normal employee"

    it "denied for accessing other's page" do
      get :show, id: allen.id
      response.should redirect_to root_path
    end
  end

  describe "GET new" do
    let(:request) { get :new }
    let(:assigns_assertion) { assigns[:employee].should be_a_new_record }
    let(:page_behavior) { render_template 'new' }
    it_should_behave_like "access by the admin", '@employee'

    it_should_behave_like "denied by the normal employee", 'new'
  end

  describe "POST create" do
    let(:request) { post :create, employee: attributes_for(:employee, email: 'test@originatechina.com', originate_start_date: Date.current) }
    let(:assigns_assertion) { assigns[:employee].should be_persisted }
    let(:page_behavior) { redirect_to employees_path }
    let(:database_performs) { Employee.all.should include assigns[:employee] }
    it_should_behave_like "access by the admin", '@employee'
    it_should_behave_like "denied by the normal employee"
  end

  describe "GET edit" do
    let(:request) { get :edit, id: sameer.id }
    let(:assigns_assertion) { assigns[:employee].nickname.should eq 'sameer' }
    let(:page_behavior) { render_template 'edit' }
    it_should_behave_like "access by the admin", '@employee'

    it_should_behave_like "denied by the normal employee", 'edit'

    context "normal user edits his own profile" do
      let(:request) { get :edit, id: peter.id }
      let(:assigns_assertion) { assigns[:employee].nickname.should eq 'peter' }
      let(:page_behavior) { render_template 'edit' }
      it_should_behave_like "access by the normal employee", '@employee'
    end
  end

  describe "PUT update" do
    let(:request) { put :update, employee: attributes_for(:employee, nickname: "alex"), id: sameer.id }
    let(:assigns_assertion) { assigns[:employee].should be_persisted }
    let(:page_behavior) { redirect_to employees_path }
    let(:database_performs) { sameer.reload.nickname.should eq 'alex' }

    it_should_behave_like "access by the admin", "@employee"
    it_should_behave_like "denied by the normal employee"

    context "normal user updates his own profile" do
      let(:request) { put :update, employee: attributes_for(:employee, nickname: "alex"), id: peter.id }
      let(:assigns_assertion) { assigns[:employee].should be_persisted }
      let(:page_behavior) { redirect_to employees_path }
      let(:database_performs) { peter.reload.nickname.should eq 'alex' }
      it_should_behave_like "access by the normal employee", '@employee'
    end
  end

  describe "DELETE destroy" do
    let(:request) { xhr :delete, :destroy, id: allen.id }
    let(:page_behavior) { render_template 'common_utils/destroy' }
    let(:database_performs) { Employee.where(id: allen.id).first.should be_nil }
    it_should_behave_like "access by the admin"
    # it_should_behave_like "denied by the normal employee"
    context "logged in as normal employee" do
      before :each do
        sign_in peter
      end

      it "redirects to root_path" do
        xhr :delete, :destroy, id: allen.id
        response.body.should include("window.location")
      end
    end
  end
end
