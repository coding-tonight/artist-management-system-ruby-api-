class Music < ApplicationRecord
  enum genre: [ :rnb, :country, :classic, :rock, :jazz ]

  validates :genre, inclusion: { in: genres.keys }

  belongs_to :singer
end
