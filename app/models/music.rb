class Music < ApplicationRecord
  enum genre: [ :rnb, :country, :classic, :rock, :jazz ]

  # validates :genre, inclusion: { in: genres.keys }
  validates :title, uniqueness: true

  belongs_to :singer, foreign_key: "singer_id"
end
