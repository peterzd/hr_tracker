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
=begin
  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

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
