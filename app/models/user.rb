class User < ActiveRecord::Base

  MAX_NAME_LENGTH = 255

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # Soft delete - uses deleted_at field
  acts_as_paranoid

  enum role: {admin: 0, member: 1}

  # In order to override the devise validations to scope by deleted_at, we have to remove
  # the validatable module and re-implement it with our changes.
  validates :email, presence: true
  validates :email, format: {with: Devise.email_regexp, allow_blank: true}, if: :email_changed?
  validates :email, uniqueness: {scope: :deleted_at}, unless: :deleted?
  validates :password, presence: true, confirmation: true, on: :create
  validates :password, length: {within: Devise.password_length, allow_blank: true}

  # Non-devise validations
  #
  # We don't validate the presence of family_name because:
  #
  #    In cultures such as parts of Southern India, Malaysia and Indonesia, a large number
  #    of people have names that consist of a given name only, with no patronym. If you
  #    require family names, you may create significant problems in these cultures, as users
  #    enter garbage data like "." or "Mr." in the family name field just to escape the form.
  #
  # From: https://www.w3.org/International/questions/qa-personal-names
  #
  validates :family_name, length: {maximum: MAX_NAME_LENGTH}
  validates :given_names, length: {maximum: MAX_NAME_LENGTH}, presence: true
  validates :role, presence: true

  ransacker :full_name do |parent|
    Arel::Nodes::InfixOperation.new('||',
      Arel::Nodes::InfixOperation.new('||',
        parent.table[:given_names], Arel::Nodes.build_quoted(' ')
      ),
      parent.table[:family_name]
    )
  end

  def full_name
    [given_names, family_name].compact.join(" ")
  end

  def to_s
    email
  end

end
