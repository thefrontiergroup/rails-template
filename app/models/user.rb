class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Soft delete - uses deleted_at field
  acts_as_paranoid

  enum role: [:admin, :member]

  validates :role, presence: true

  def to_s
    email
  end

end
