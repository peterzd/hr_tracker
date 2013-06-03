require 'spec_helper'

describe EmployeesController do
  helper_objects

  describe "GET index" do
    before :each do
      sameer.save
      peter.save
      allen.save
      andy.save
    end

    context "logged in as the system admin" do
      before :each do
        sign_in sameer
      end

      it "renders the index page" do
        get :index
        response.should render_template 'index'
      end

      it "assigns the @employees with all the employees that are current employee" do
        get :index
        assigns[:employees].count.should eq Employee.current_employees.count
      end
    end

    context "logged in as a normal employee" do
      before :each do
        sign_in peter
      end

      it "renders the page" do
        get :index
        response.should render_template 'index'
      end
    end
  end

  describe "GET show" do
    context "logged in as the system admin" do
      before :each do
        sign_in sameer
      end

      it "shows the detail of the employee" do
        get :show, id: peter.id
        response.should render_template 'show'
      end
    end

    context "logged in as a normal employee" do
      before :each do
        sign_in peter
      end

      it "shows my own detail" do
        get :show, id: peter.id
        response.should render_template 'show'
      end

      it "can not access other's detail" do
        get :show, id: allen.id
        response.should redirect_to root_path
      end
    end
  end

  describe "GET new" do
    context "logged in as system admin" do
      before :each do
        sign_in sameer
      end

      it "renders the new page" do
        get :new
        response.should render_template 'new'
      end

      it "assigns the employee with a new record" do
        get :new
        assigns[:employee].should be_a_new_record
      end
    end

    context "logged in as a normal employee" do
      before :each do
        sign_in peter
      end

      it "can not access the new page" do
        get :new
        response.should redirect_to root_path
      end
    end
  end

  describe "POST create" do
    context "logged in as system admin" do
      before :each do
        sign_in sameer
      end

      it "creates a new Employee in database" do
        expect{ post :create, employee: attributes_for(:employee, email: 'test@originatechina.com', originate_start_date: Date.current)}.to change(Employee, :count).by(1)
      end

      it "assigns the newly employee to @employee" do
        post :create, employee: attributes_for(:employee, email: 'test@originatechina.com', originate_start_date: Date.current)
        assigns[:employee].should be_persisted
      end

      it "redirects to the index page" do
        post :create, employee: attributes_for(:employee, email: 'test@originatechina.com', originate_start_date: Date.current)
        response.should redirect_to employees_path
      end
    end

    context "logged in as system admin" do
    end
=begin
    describe "with valid params" do
      it "creates a new Employee" do
        expect {
          post :create, {:employee => valid_attributes}, valid_session
        }.to change(Employee, :count).by(1)
      end

      it "assigns a newly created employee as @employee" do
        post :create, {:employee => valid_attributes}, valid_session
        assigns(:employee).should be_a(Employee)
        assigns(:employee).should be_persisted
      end

      it "redirects to the created employee" do
        post :create, {:employee => valid_attributes}, valid_session
        response.should redirect_to(Employee.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved employee as @employee" do
        # Trigger the behavior that occurs when invalid params are submitted
        Employee.any_instance.stub(:save).and_return(false)
        post :create, {:employee => { "name" => "invalid value" }}, valid_session
        assigns(:employee).should be_a_new(Employee)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Employee.any_instance.stub(:save).and_return(false)
        post :create, {:employee => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
=end
  end

=begin
  describe "PUT edit" do
    it "assigns the requested employee as @employee" do
      employee = Employee.create! valid_attributes
      get :edit, {:id => employee.to_param}, valid_session
      assigns(:employee).should eq(employee)
    end
  end


  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested employee" do
        employee = Employee.create! valid_attributes
        # Assuming there are no other employees in the database, this
        # specifies that the Employee created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Employee.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
        put :update, {:id => employee.to_param, :employee => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested employee as @employee" do
        employee = Employee.create! valid_attributes
        put :update, {:id => employee.to_param, :employee => valid_attributes}, valid_session
        assigns(:employee).should eq(employee)
      end

      it "redirects to the employee" do
        employee = Employee.create! valid_attributes
        put :update, {:id => employee.to_param, :employee => valid_attributes}, valid_session
        response.should redirect_to(employee)
      end
    end

    describe "with invalid params" do
      it "assigns the employee as @employee" do
        employee = Employee.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Employee.any_instance.stub(:save).and_return(false)
        put :update, {:id => employee.to_param, :employee => { "name" => "invalid value" }}, valid_session
        assigns(:employee).should eq(employee)
      end

      it "re-renders the 'edit' template" do
        employee = Employee.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Employee.any_instance.stub(:save).and_return(false)
        put :update, {:id => employee.to_param, :employee => { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested employee" do
      employee = Employee.create! valid_attributes
      expect {
        delete :destroy, {:id => employee.to_param}, valid_session
      }.to change(Employee, :count).by(-1)
    end

    it "redirects to the employees list" do
      employee = Employee.create! valid_attributes
      delete :destroy, {:id => employee.to_param}, valid_session
      response.should redirect_to(employees_url)
    end
  end
=end
end
