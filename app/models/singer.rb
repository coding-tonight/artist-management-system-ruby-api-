class Singer < ApplicationRecord
  max_paginates_per 10
  paginates_per 50

  enum gender: [ :male, :female, :other ]

  has_many :musics, dependent: :destroy
  accepts_nested_attributes_for :musics
  validates :name, uniqueness: true
  validates :gender, inclusion: { in: genders.keys }

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Singer.new(row.to_hash).save
    end
  end

  def self.to_csv
    attributes = %w[id name gender address dob first_release_year no_of_albums_released ]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |singer|
        csv << attributes.map { |attr| singer.send(attr) }
      end
    end
  end
end
