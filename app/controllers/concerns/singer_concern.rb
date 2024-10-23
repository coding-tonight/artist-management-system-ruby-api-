module SingerConcern
  extend ActiveSupport::Concern

  def retrive_singer_musics
    begin
      Music.where(singer_id: params[:id]).select(:id, :title, :genre, :album_name, :singer_id)
    rescue ActiveModel::ActiveNotFound => e
      raise e
    end
  end

  def retrive_singers
    @singers = Singer.select(
      :id, :name, :dob, :gender, :address, :first_release_year, :no_of_albums_released
      ).page(current_page).per(per_page).order(:name)
  end
end
