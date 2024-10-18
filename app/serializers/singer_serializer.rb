class SingerSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :album_name, :gender
  has_many :musics
end
