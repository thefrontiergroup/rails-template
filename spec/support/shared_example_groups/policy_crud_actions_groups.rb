shared_examples_for "Policy without access to CRUD actions" do
  it { should_not permit_access_to(:index) }
  it { should_not permit_access_to(:new) }
  it { should_not permit_access_to(:create) }
  it { should_not permit_access_to(:edit) }
  it { should_not permit_access_to(:update) }
  it { should_not permit_access_to(:destroy) }
end