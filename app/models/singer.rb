class Singer < ApplicationRecord
  max_paginates_per 10
  paginates_per 50

  enum gender: [ :male, :female, :other ]

  has_many :musics, dependent: :destroy
  belongs_to :user, foreign_key: "user_id", optional: true
  accepts_nested_attributes_for :musics
  validates :name, uniqueness: true
  validates :gender, inclusion: { in: genders.keys }

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      singer_hash =  row.to_hash
      singer = Singer.find_or_initialize_by(name: singer_hash["name"])
      singer.assign_attributes(singer_hash)
      if singer.save
        puts "Saved #{singer.name}"
      else
        puts "Failed to save #{singer.name}: #{singer.errors.full_messages.join(", ")}"
      end
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
