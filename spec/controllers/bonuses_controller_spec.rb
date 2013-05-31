require 'spec_helper'

describe BonusesController do
  helper_objects

  describe "GET 'index'" do

    context "logged in as system admin" do
      before :each do
        sign_in sameer
        sameer.bonuses << create_list(:bonus, 5)
      end

      it "lists all the bonuses of my-self" do
        get :index, nickname: sameer.nickname
        assigns[:bonuses].count.should == sameer.bonuses.count
      end

      it "can access others bonuses" do
        get :index, nickname: peter.nickname
        response.should be_success
      end
    end

    context "logged in as the owner employee" do
      before :each do
        sign_in peter
        peter.bonuses << create_list(:bonus, 7)
      end

      it "lists all the bonuses of my-self" do
        get :index, nickname: peter.nickname
        assigns[:bonuses].count.should == peter.bonuses.count
      end

      it "can't access others bonuses" do
        get :index, nickname: allen.nickname
        response.should redirect_to root_path
      end
    end
  end

  describe "GET 'new'" do
    context "logged in as system admin" do
      before :each do
        sign_in sameer
      end

      it "creates a new empty bonus for my self" do
        get :new, nickname: 'sameer'
        assigns[:bonus].should be_new_record
      end

      it "creates a new empty bonus for other employee" do
        get :new, nickname: peter.nickname
        assigns[:bonus].should be_new_record
      end

      it "renders the new page" do
        get :new, nickname: 'sameer'
        response.should render_template 'new'
      end
    end

    context "logged in as normal user" do
      before :each do
        sign_in peter
        get :new, nickname: peter.nickname
      end

      it "can not access the page" do
        response.should_not render_template 'new'
      end

      it "redirects to the root page" do
        response.should redirect_to root_path
      end

    end
  end

  describe "POST 'create'" do
    context "logged in as system admin" do

      before :each do
        sign_in sameer
      end

      it "creates a new bonus for the employee" do
        post :create, nickname: peter.nickname, bonus: attributes_for(:bonus, amount: 1000)
        assigns[:bonus].employee.id.should == peter.id
      end

      it "saves the bonus in database" do
        expect { post :create, nickname: peter.nickname, bonus: attributes_for(:bonus, amount: 1000) }.to change{ peter.bonuses.count}.by(1)
      end

    end

    context "logged in as normal employee" do
      before :each do
        sign_in peter
      end

      it "can not be accessed" do
        post :create, nickname: peter.nickname, bonus: attributes_for(:bonus, amount: 1000)
        response.should redirect_to root_path
      end

      it "can not change the count in database" do
        expect{post :create, nickname: peter.nickname, bonus: attributes_for(:bonus, amount: 1000)}.to_not change{ peter.bonuses.count}
      end

    end
  end

  describe "GET 'edit'" do
    let(:peter_bonus) { create(:bonus, amount: 1111, employee: peter) }

    context "logged in as system admin" do

      before :each do
        sign_in sameer
        get :edit, nickname: peter.nickname, id: peter_bonus.id
      end

      it "renders the edit page" do
        response.should render_template 'edit'
      end

      it "assigns the determined employee's bonus" do
        assigns[:bonus].employee.should == peter
      end
    end

    context "logged in as normal employee" do
      before :each do
        sign_in peter
      end

      it "can not access the edit page" do
        get :edit, nickname: peter.nickname, id: peter_bonus.id
        response.should redirect_to root_path
      end
    end

  end

  describe "PUT 'update'" do
    let(:peter_bonus) { create(:bonus, amount: 1111, employee: peter) }

    context "logged in as system admin" do
      before :each do
        sign_in sameer
      end

      it "changes the attributes of the bonus" do
        expect{ put :update, nickname: peter.nickname, id: peter_bonus.id, bonus: attributes_for(:bonus, amount: 1122)}.to change{ peter_bonus.reload.amount }.from(1111).to(1122)
      end

      it "changes the employee's bonus attribute" do
        put :update, nickname: peter.nickname, id: peter_bonus.id, bonus: attributes_for(:bonus, amount: 1122)
        peter.bonuses.find(peter_bonus.id).amount.should eq 1122
      end


      it "redirects to the bonuses index page" do
        put :update, nickname: peter.nickname, id: peter_bonus.id, bonus: attributes_for(:bonus, amount: 1122)
        response.should redirect_to bonuses_path
      end
    end

    context "logged in as normal employee" do
      before :each do
        sign_in peter
      end

      it "can not be successful" do
        put :update, nickname: peter.nickname, id: peter_bonus.id, bonus: attributes_for(:bonus, amount: 1122)
        response.should redirect_to root_path
      end
    end
  end


  describe "DELETE 'destroy'" do
    let(:peter_bonus) { create(:bonus, amount: 1111, employee: peter) }

    context "logged in as system admin" do
      before :each do
        sign_in sameer
      end

      it "deletes the bonus" do
        peter_bonus.save
        expect{ delete :destroy, nickname: peter.nickname, id: peter_bonus.id }.to change{ Bonus.all.count }.by(-1)
      end

      it "redirects to the bonuses page" do
        delete :destroy, nickname: peter.nickname, id: peter_bonus.id
        response.should redirect_to bonuses_path
      end

      it "removes the bonus from the employee's bonuses" do
        delete :destroy, nickname: peter.nickname, id: peter_bonus.id
        peter.bonuses.should_not include(peter_bonus)
      end
    end

    context "logged in as normal employee" do
      before :each do
        sign_in peter
      end

      it "can not do the operation" do
        delete :destroy, nickname: peter.nickname, id: peter_bonus.id
        response.should redirect_to root_path
      end
    end
  end

  describe "GET 'show'" do
    let(:peter_bonus) { create(:bonus, amount: 1111, employee: peter) }
    let(:allen_bonus) { create(:bonus, amount: 2222, employee: allen) }
    let(:sameer_bonus) { create(:bonus, amount: 3333, employee: sameer) }

    context "logged in as system admin" do
      before :each do
        sign_in sameer
      end

      it "can access other's bonuses" do
        get :show, nickname: peter.nickname, id: peter_bonus
        response.should render_template 'show'
      end

      it "can access my own bonuses" do
        get :show, nickname: sameer.nickname, id: sameer_bonus
        response.should render_template 'show'
      end

      it "assigns the corresponding bonus" do
        get :show, nickname: peter.nickname, id: peter_bonus
        assigns[:bonus].employee.should eq peter
      end
    end

    context "logged in as normal employee" do
      before :each do
        sign_in peter
      end

      it "can not access other's bonuses" do
        get :show, nickname: allen.nickname, id: allen_bonus
        response.should redirect_to root_path
      end

      it "can access my own's bonuses" do
        get :show, nickname: peter.nickname, id: peter_bonus
        response.should render_template 'show'
      end

      it "assigns my own's bonus" do
        get :show, nickname: peter.nickname, id: peter_bonus
        assigns[:bonus].employee.should eq peter
      end
    end
  end
end
