class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # Soft delete - uses deleted_at field
  acts_as_paranoid

  enum role: {admin: 0, member: 1}

  belongs_to :site

  # In order to override the devise validations, I have to remove the validatable module
  # and re-implement it with some changes
  validates :email, presence: true
  validates :email, format: {with: Devise.email_regexp, allow_blank: true}, if: :email_changed?
  validates :email, uniqueness: {scope: :deleted_at}, unless: :deleted?
  validates :password, presence: true, confirmation: true, on: :create
  validates :password, length: {within: Devise.password_length, allow_blank: true}

  # Non-devise validations
  validates :role, presence: true

  # User.email_search("jordan")
  scope :email_search, -> (email) { where("email ILIKE ?", "%#{email}%") }

  scope :created_at_between, -> (start_date, end_date) { where(created_at: start_date.beginning_of_day..end_date.end_of_day) }

  scope :with_site_named, -> (site_name) { joins(:site).merge(Site.named(site_name)) }

  # Search for user state
  # User.in_state(33)
  scope :in_state, -> (state_id) { joins(site: :address).where(addresses: {state_id: state_id}) }

  # Search for user postcode
  scope :in_post_code, -> (post_code) { joins(site: :address).where(addresses: {post_code: post_code}) }

  #search for updates between two dates, before a date, after a date.
  scope :updated_at_between, -> (start_date, end_date) { where(updated_at: start_date.beginning_of_day..end_date.end_of_day) }

  scope :updated_at_before, -> (end_date) { where('updated_at <= ?', end_date.end_of_day) }

  scope :updated_at_after, -> (start_date) { where('updated_at >= ?', start_date.beginning_of_day) }
  # Search for rural users
  scope :in_rural_area, -> (rural) { joins(:site).where(sites: {rural: rural})}

  def to_s
    email
  end

end