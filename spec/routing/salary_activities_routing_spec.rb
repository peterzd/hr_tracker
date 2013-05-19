require "spec_helper"

describe SalaryActivitiesController do
  describe "routing" do

    it "routes to #index" do
      get("/salary_activities").should route_to("salary_activities#index")
    end

    it "routes to #new" do
      get("/salary_activities/new").should route_to("salary_activities#new")
    end

    it "routes to #show" do
      get("/salary_activities/1").should route_to("salary_activities#show", :id => "1")
    end

    it "routes to #edit" do
      get("/salary_activities/1/edit").should route_to("salary_activities#edit", :id => "1")
    end

    it "routes to #create" do
      post("/salary_activities").should route_to("salary_activities#create")
    end

    it "routes to #update" do
      put("/salary_activities/1").should route_to("salary_activities#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/salary_activities/1").should route_to("salary_activities#destroy", :id => "1")
    end

  end
end
