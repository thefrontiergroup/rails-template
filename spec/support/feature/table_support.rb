module Feature::TableSupport

  def first_row
    nth_row(1)
  end

  def second_row
    nth_row(2)
  end

  def nth_row(num)
    find("table tbody tr:nth-child(#{num})")
  end

end