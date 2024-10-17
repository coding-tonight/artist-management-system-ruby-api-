class Singer < ApplicationRecord
  max_paginates_per 10
  paginates_per 50

  enum gender: [:male, :female, :other]

  has_many :musics, dependent: :destroy
  accepts_nested_attributes_for :musics
  validates :name, uniqueness: true
  validates :gender, inclusion: ( in: genders.keys )
end
