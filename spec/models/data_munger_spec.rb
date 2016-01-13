require 'rails_helper'

describe DataMunger do

  describe '#extract_emails' do
    subject { DataMunger.new.extract_emails(emails) }
    let(:emails) do
      [
        "email@example.com",
        "jordan@thefrontiergroup.com.au"
      ]
    end

    # Hints: regex is one option
    # rubular.com
    # Use .map to perform an operation on a collection of things
    # EG:
    # [1,2].map {|x| x * 2} # => [2, 4]
    it { should eq(["email", "jordan"])}

  end

  describe '#extract_domain_from_email' do
    subject { DataMunger.new.extract_domain_from_email(emails) }
    let(:emails) { ["jordan@example.com", "ben@subdomain.domain.com"] }

    it { should eq(["example", "subdomain.domain"]) }
  end

  describe '#return_values_where_string_is_odd_number' do
    subject { DataMunger.new.return_values_where_string_is_odd_number(numbers) }
    let(:numbers) { ["One", "Two", "Three", "Four", "Five", "Six"] }

    it { should eq(["One", "Two", "Three", "Six"]) }
  end

  describe '#return_with_even_number_of_vowels' do
    subject {DataMunger.new.return_with_even_number_of_vowels(vowels) }
    let(:vowels) { ["Alphabet", "Tree", "Basket", "Elephant"] }

    it { should eq(["Tree", "Basket"]) }
  end

  describe '#order_by_length_of_email' do
    subject { DataMunger.new.order_by_length_of_email(email) }
    let(:email) { ["jordan@example.com", "alpha@bravo.com", "zeta_anderson@alpha.com"] }

    it { should eq( ["alpha@bravo.com", "jordan@example.com", "zeta_anderson@alpha.com"]) }
  end

  describe '#order_emails_domain_by_alpha' do
    subject { DataMunger.new.order_emails_domain_by_alpha(email) }
    let(:email) { ["jordan@example.com", "alpha@bravo.com", "zeta_anderson@alpha.com"] }

    it { should eq( ["zeta_anderson@alpha.com", "alpha@bravo.com", "jordan@example.com"]) }
  end

  #[HARD] Return a collection of the unique consonants used in the emails, ordered in reverse alpha order
  describe '#unique_consonants_in_reverse_alpha' do
    subject { DataMunger.new.unique_consonants_in_reverse_alpha(email) }
    let(:email) { ["jordan@example.com", "alpha@bravo.com", "zeta_anderson@alpha.com"] }

    it { should eq( "zxvtsrpnmljhdcb" ) }
  end

  #  For a given set of names, return the first names as initials only,
  #  and the last name in full. Ensure that the initial and the first letter in the last name are capitalized.
  describe '#initialize_first_names_not_last' do
    subject { DataMunger.new.initialize_first_names_not_last(name) }

    describe "will not initliaze a single name" do
      let(:name) { "BEN" }
      let(:expected_name) { "Ben" }

      it { should eq(expected_name) }
    end

    describe "can initialize users with one first and last name" do
      let(:name) { "benjamin franklin" }
      let(:expected_name) { "B. Franklin" }

      it { should eq(expected_name) }
    end

    describe "can initialize users with a first, middle, and last name" do
      let(:name) { "Jordan Alexander Maguire" }
      let(:expected_name) { "J. A. Maguire" }

      it { should eq(expected_name) }
    end

    #Dayify a string! Add 'day' to the string unless the string already ends in day
    describe '#dayify_string' do
      subject { DataMunger.new.dayify_string(day) }

      describe "string doesnt have day on the end" do
        let(:day) { "wednesboot" }
        let(:expected_day) { "wednesbootday"}

        it { should eq(expected_day) }
      end

      describe "string has day on the end" do
        let(:day) { "monday" }
        let(:expected_day) { "monday" }

        it { should eq(expected_day) }
      end

      describe "string doesnt have day on the end but has day in the name" do
        let(:day) { "daytona" }
        let(:expected_day) { "daytonaday" }

        it { should eq(expected_day) }
      end

      #Lil Jon a sentence (#liljonify). At the end of each sentence (marked by a full stop)
      #write "YEAH!" or "OKAY!!". In that order.
      #Repeat this pattern after each sentence. Each time you put an Lil Jon style
      #exclamation in you should increase the number of '!' by one.
      describe "#liljonify" do
        subject { DataMunger.new.liljonify(sentence) }

        describe "one sentence ending" do
          let(:sentence) { "I like turtles." }
          let(:liljonify) { "I like turtles. YEAH!" }

          it { should eq(liljonify) }
        end

        describe "two sentences" do
          let(:sentence) { "I don't like bushes. They scare me." }
          let(:liljonify) { "I don't like bushes. YEAH! They scare me. OKAY!!" }

          it { should eq(liljonify) }
        end

        describe "long sentence" do
          let(:sentence) do
            [
              "Do not attempt to challenge my authority.",
              "I have eight weeks to turn you gaggle of maggots into a well-discipline cadet unit.",
              "From this day forward your sorry asses belong to me.",
              "You will not eat, sleep, drink, blow your nose or dig in your butts without my say so.",
              "Know this, killing is my business, ladies, and business is good."
              ].join(" ")
            end

          let(:liljonify) do
            [
              "Do not attempt to challenge my authority. YEAH!",
              "I have eight weeks to turn you gaggle of maggots into a well-discipline cadet unit. OKAY!!",
              "From this day forward your sorry asses belong to me. YEAH!!!",
              "You will not eat, sleep, drink, blow your nose or dig in your butts without my say so. OKAY!!!!",
              "Know this, killing is my business, ladies, and business is good. YEAH!!!!!"
            ].join(" ")
          end

          it { should eq(liljonify) }
        end
      end
    end
  end
end