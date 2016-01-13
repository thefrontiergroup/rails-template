class DataMunger

  def extract_emails(array_of_emails)
    array_of_emails.map {|email| email.split("@").first }
  end

  def extract_domain_from_email(array_of_emails)
    array_of_emails.map {|email| email.gsub(/.*@/, "").gsub(/\.[^\.]*\z/, "")}
  end

  def return_values_where_string_is_odd_number(array_of_numbers)
    array_of_numbers.select {|number| number.length.odd?}
  end

  def return_with_even_number_of_vowels(array_of_vowels)
    array_of_vowels.select {|vowels| vowels.count("aeiouAEIOU").even? }
  end

  def order_by_length_of_email(array_of_emails)
    array_of_emails.sort_by {|email| email.length }
  end

  def order_emails_domain_by_alpha(array_of_emails)
    array_of_emails.sort {|email| email.length }
  end

  def unique_consonants_in_reverse_alpha(array_of_emails)
    array_of_emails.flat_map {|email| email.scan(/[^aeiou\W\_]/i)}.uniq.sort.join.reverse
  end

  def initialize_first_names_not_last(full_name)
    all_names = full_name.split(" ")
    first_names = all_names[0..-2]
    last_name   = all_names.last.capitalize

    initials = first_names.map {|name| name.first.upcase.concat(".")}
    (initials << last_name).join(" ")
  end

  def dayify_string(name)
    name.ends_with?("day") ? name : name.concat("day")
    # if name.ends_with?("day")
    #   name
    # else
    #   name.concat("day")
    # end
  end

  def liljonify(sentence)
    lil = sentence.split(".")
    lil.each_with_index.map do |line, i|
      lil_jon_exclamation = i.even? ? "YEAH" : "OKAY"  # YEAH, or OKAY
      exclamation_points  = Array.new(i + 1, "!").join # !!
      # Do not attempt to challenge my authority. YEAH!
      line.concat(". ").concat(lil_jon_exclamation).concat(exclamation_points)
    end.join("")
  end

end