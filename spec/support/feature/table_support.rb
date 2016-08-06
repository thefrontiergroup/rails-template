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

  def within_row(name)
    # Ensure that " are used here since ' will fail when the name has a ' in it.
    # For example, searching for a user named John O'Hanniganskivic
    within(:xpath, "//tr[td[contains(., \"#{name}\")]]") { yield }
  end

end
