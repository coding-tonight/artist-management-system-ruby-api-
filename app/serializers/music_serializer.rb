class MusicSerializer < ActiveModel::Serializer
  attributes :id, :title, :genre
  belongs_to :singer
end
