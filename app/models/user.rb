class User < ApplicationRecord

  enum role: %i[super_admin artist_manager artist]
  enum gender: %i[male female other]

  validates :email, uniqueness: true
  validates_format_of :email, with: /@/, format: URI::MailTo::EMAIL_REGEXP
  validates :password_digest, presence: true
  # validates :role , inclusion: { in: roles.keys , message: "Invalid gender option"}
  # validates :gender , inclusion: { in: genders.keys , message: "Invalid role"}

  has_secure_password
end
