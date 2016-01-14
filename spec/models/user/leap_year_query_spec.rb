require 'rails_helper'

RSpec.describe User::LeapYearQuery do

  describe ".leap_year_users", focus: true do
    subject { User::LeapYearQuery.new.leap_year_users }

    context "user birth_date is leap year" do
      before { FactoryGirl.create(:user, email: "member@random.com", birth_date: "1996/01/14") }

      it { should include("member 14/01/1996") }
    end

    context 'user birth_date is not leap year' do
      before {FactoryGirl.create(:user, birth_date: "1997/01/14") }

      it {should eq( [] ) }
    end
  end

end