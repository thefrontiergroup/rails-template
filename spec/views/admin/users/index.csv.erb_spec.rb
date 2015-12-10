require 'rails_helper'

RSpec.describe 'admin/users/index.csv.erb' do
  subject { rendered }

  let(:users) { FactoryGirl.build_list(:user, 1, email: "jordan@example.com") }

  before do
    assign :users, users
    render
  end

  let(:expected) do
    expected = <<MSG
Email
jordan@example.com
MSG
  end

  it { should eq(expected) }
end
