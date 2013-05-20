require 'spec_helper'

describe "SalaryActivities" do
  describe "GET /salary_activities" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get salary_activities_path
      response.status.should be(200)
    end
  end
end
