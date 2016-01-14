class User::LeapYearQuery

  def leap_year_users
    users_with_leap_year_birth_date = User.all.find_all do |user|
      Leap_Year.new.is_leap_year(user.birth_date.year)
    end

    users_email_as_name = users_with_leap_year_birth_date.map do |user|
      email = DataMunger.new.extract_emails([user.email])[0]
      year = user.birth_date.strftime('%d/%m/%Y')
      email.concat(" ").concat(year)
    end
  end
end