class Address < ActiveRecord::Base

  # Ensure that an address has a line_1, a state, and a post_code
  validates :line_1,  presence: true
  validates :state_id, presence: true
  validates :post_code, presence: true


end
