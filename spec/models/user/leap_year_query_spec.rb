require 'rails_helper'

RSpec.describe User::LeapYearQuery do

  # describe "users between date range" do
  #   subject { User::LeapYearQuery.new.leap_year_users(start_date, end_date)}
  #   let(:start_date) { "1993/01/13" }
  #   let(:end_date) { "1999/01/13" }

  #   # it { should     include(FactoryGirl.create(:user, birth_date: "1996")) }
  #   # it { should_not include(FactoryGirl.create(:user, birth_date: "2000")) }
  #   # it { should_not include(FactoryGirl.create(:user, birth_date: "1992")) }
  #   # it { should_not include(FactoryGirl.create(:user, birth_date: "1995")) }
  # end

  describe ".leap_year_users" do
    subject { User::LeapYearQuery.new.leap_year_users(start_date, end_date) }

    let(:start_date) { Date.new(1995, 1, 13) }
    let(:end_date)   { Date.new(1999, 1, 13) }

    def user_with_birth_date(birth_date)
      FactoryGirl.create(:user, birth_date: birth_date, email: "jordan@example.com")
      "jordan #{birth_date}"
    end

    it { should include(user_with_birth_date("14/01/1996")) }
    it { should_not include(user_with_birth_date("14/01/1994")) }
    it { should_not include(user_with_birth_date("14/01/2000")) }
    it { should_not include(user_with_birth_date("14/01/1997")) }
  end


end