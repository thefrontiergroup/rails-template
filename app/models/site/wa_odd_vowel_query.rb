class Site::WaOddVowelQuery

  # Access with Site::WaOddVowelQuery.new.users_in_wa_with_odd_vowels
  def users_in_wa_with_odd_vowels
    user_in_wa = User.joins({site: {address: :state}}).where(states: {abbreviation: "WA"} )
    user_in_wa.select do |user|
      user.first_name.concat(user.last_name).count("aeiouAEIOU").odd?
    end

  end
end