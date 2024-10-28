class User < ApplicationRecord
  enum role: %i[super_admin artist_manager artist]
  enum gender: %i[male female other]

  has_one :singer

  validates :email, uniqueness: true
  validates_format_of :email, with: /@/, format: URI::MailTo::EMAIL_REGEXP
  validates :password, presence: { on: :create }
  # validate :password, length: { minimum: 6 }

  has_secure_password
end
