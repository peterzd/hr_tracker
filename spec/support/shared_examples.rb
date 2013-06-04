shared_examples "successful render page" do |page|
  it "renders the #{page} page"do
    response.should render_template page
  end
end

shared_examples "assigns variable" do |variable|
  it "assigns the #{variable} with the assertion" do
    assigns_assertion.should be_true
  end
end

shared_examples "access by the admin" do |target_page, variable|
  before :each do
    sign_in sameer
    request
  end

  it_should_behave_like "successful render page", target_page
  if variable
    it_should_behave_like "assigns variable", variable
  end
end

shared_examples "access by the normal employee" do |target_page, variable|
  before :each do
    sign_in peter
    request
  end

  it_should_behave_like "successful render page", target_page
  if variable
    it_should_behave_like "assigns variable", variable
  end
end
