class Leap_Year

  def is_leap_year(year)
    year % 4 == 0 &&
    year % 100 != 0 ||
    year % 400 == 0
  end


end