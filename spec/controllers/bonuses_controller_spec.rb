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

      it "saves the bonus in DB" do
        expect { post :create, nickname: peter.nickname, bonus: attributes_for(:bonus, amount: 1000) }.to change{ peter.bonuses.count}.by(1)
      end

    end

    context "logged in as normal employee" do
      before :each do
        sign_in peter
      end




    end
  end

=begin
  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit'
      response.should be_success
    end
  end

  describe "GET 'update'" do
    it "returns http success" do
      get 'update'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      get 'destroy'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end
=end
end
