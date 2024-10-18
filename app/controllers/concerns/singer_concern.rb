module SingerConcern
  extend ActiveSupport::Concern

  include Pagination

  def retrive_singer_musics
    Music.where(singer_id: params[:id]).select(:id, :title, :genre, :singer_id)
  end

  def retrive_singers
    puts Singer.all.inspect
    @singers = Singer.select(
      :id, :name, :dob, :gender, :address, :first_release_year, :no_of_albums_released
      ).page(current_page).per(per_page).order(:name)
  end
end
