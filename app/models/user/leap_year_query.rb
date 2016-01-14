class User::LeapYearQuery

  def leap_year_users(start_date, end_date)
    # More concise:
    #   users_with_leap_year_birth_date = User.all.find_all(&method(:is_leap_year_user?))
    #   users_with_leap_year_birth_date.map(&method(:format_leap_year_user))
    # Most concise:
    #   User.all.find_all(&method(:is_leap_year_user?)).map(&method(:format_leap_year_user))

    users_birth_date_between_range = User.where(birth_date: start_date.beginning_of_day..end_date.end_of_day)

    users_with_leap_year_birth_date = users_birth_date_between_range.find_all do |user|
      is_leap_year_user?(user)
    end

    users_with_leap_year_birth_date.map do |user|
      format_leap_year_user(user)
    end
  end

private

  def format_leap_year_user(user)
    email = DataMunger.new.extract_emails([user.email])[0]
    year = user.birth_date.strftime('%d/%m/%Y')
    email.concat(" ").concat(year)
  end

  def is_leap_year_user?(user)
    LeapYear.new.is_leap_year(user.birth_date.year)
  end

end