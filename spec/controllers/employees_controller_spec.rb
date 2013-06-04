require 'spec_helper'

describe EmployeesController do
  helper_objects

  describe "GET index" do
    before :each do
      [sameer, peter, allen, andy].each(&:save)
    end

    let(:request) { get :index }
    let(:assigns_assertion) { assigns[:employees].count == Employee.current_employees.count }
    it_should_behave_like "access by the admin", 'index', '@employees'
    it_should_behave_like "access by the normal employee", "index", "@employees"
  end

  describe "GET show" do

    let(:request) { get :show, id: peter.id }
    it_should_behave_like "access by the admin", 'show'
    it_should_behave_like "access by the normal employee", 'show'

    it "for other's profile" do
      get :show, id: allen.id
      response.should redirect_to root_path
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

    context "logged in a normal employee" do
      before :each do
        sign_in peter
      end

      it "can not access" do
        post :create, employee: attributes_for(:employee, email: 'test@originatechina.com', originate_start_date: Date.current)
        response.should redirect_to root_path
      end
    end
  end

  describe "GET edit" do
    context "logged in as system admin" do
      before :each do
        sign_in sameer
      end

      it "renders the edit page" do
        get :edit, id: sameer.id
        response.should render_template 'edit'
      end

      it "assigns the edited employee to @employee" do
        get :edit, id: sameer.id
        assigns[:employee].nickname.should eq 'sameer'
      end
    end

    context "logged in a normal employee" do
      before :each do
        sign_in peter
      end

      context "edit other's profile" do
        it "can not access other's edit page" do
          get :edit, id: allen.id
          response.should redirect_to root_path
        end
      end

      context "edit my own profile" do
        it "can access his own profile" do
          get :edit, id: peter.id
          response.should render_template 'edit'
        end

        it "assigns the edited employee to @employee" do
          get :edit, id: peter.id
          assigns[:employee].nickname.should eq 'peter'
        end
      end
    end
  end

  describe "PUT update" do
    context "logged in as system admin" do
      before :each do
        sign_in sameer
      end

      it "updates the attributes of this employee in the database" do
        put :update, employee: attributes_for(:employee, nickname: "alex"), id: peter.id
        peter.reload.nickname.should eq 'alex'
      end

      it "reditects to employees index page" do
        put :update, employee: attributes_for(:employee, nickname: "alex"), id: peter.id
        response.should redirect_to employees_path
      end
    end

    context "logged in a normal employee" do
      before :each do
        sign_in peter
      end

      it "can not update other's profile" do
        put :update, employee: attributes_for(:employee, nickname: "alex"), id: allen.id
        response.should redirect_to root_path
      end

      context "with valid params" do
        it "can update my own's profile with valid attributes" do
          put :update, employee: attributes_for(:employee, nickname: "alex"), id: peter.id
          peter.reload.nickname.should eq 'alex'
        end

        it "redirects to the employees index page" do
          put :update, employee: attributes_for(:employee, nickname: "alex"), id: peter.id
          response.should redirect_to employees_path
        end
      end

      context "with invalid params" do
        pending "set some invalid params"
      end
    end
  end

  describe "DELETE destroy" do
    context "logged in as system admin" do
      let(:request) { delete :destroy, id: allen.id }

      before :each do
        sign_in sameer
        allen.save
      end

      it "destroys the requested employee" do
        request
        Employee.all.should_not include allen
      end

      it "removes a record from database" do
        expect{ request }.to change{Employee.count}.by(-1)
      end

      it "redirects to the employees list" do
        request
        response.should redirect_to employees_path
      end
    end

    context "logged in as a normal employee" do
      before :each do
        sign_in peter
      end

      it "can not destroys my self in the database" do
        peter.save
        expect{ delete :destroy, id: peter.id }.to_not change{ Employee.count }
      end


      it "can not do the operation" do
        delete :destroy, id: peter.id
        response.should redirect_to root_path
      end
    end
  end
end
