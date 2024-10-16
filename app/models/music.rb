class Music < ApplicationRecord
  enum genre: {
    rnb: "rnb",
    country: "country",
    classic: "classic",
    rock: "rock",
    jazz: "jazz"
  }

  belongs_to :singer
end
