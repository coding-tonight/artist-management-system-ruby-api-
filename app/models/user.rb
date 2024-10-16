class User < ApplicationRecord
  enum gender: {
    male: "male",
    female: "female",
    other: "other"
  }
  enum role: {
    super_admin: "super_admin",
    artist_manager: "artist_manager",
    artist: "artist"
  }
  validates :email, uniqueness: true
  validates_format_of :email, with: /@/
  validates :password_digest, presence: true

  has_secure_password
end
