class Singer < ApplicationRecord
  enum gender: {
    male: "male",
    female: "female",
    other: "other"
  }

  has_many :musics, dependent: :destroy
  accepts_nested_attributes_for :musics
  validates :name, uniqueness: true
end
