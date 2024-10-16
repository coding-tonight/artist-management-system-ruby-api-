class Singer < ApplicationRecord
  enum gender: {
    male: "male",
    female: "female",
    other: "other"
  }

  has_many :music, dependent: :destroy
  validates :name, uniqueness: true
end
