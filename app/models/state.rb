class State < ActiveRecord::Base

  validates :abbreviation, uniqueness: true, presence: true
  validates :name, uniqueness: true, presence: true

  def to_s
    abbreviation
  end

end
