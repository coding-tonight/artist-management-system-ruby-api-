module MusicConcern
  extend ActiveSupport::Concern

  def retrive_musics
    @singers = Music.select(
      "musics.id", "musics.title", "musics.genre", "musics.album_name",
      "musics.singer_id", "singers.name AS artist_name"
    ).joins(
      "INNER JOIN singers ON musics.singer_id = singers.id"
    ).page(current_page).per(per_page).order(:title)
  end
end
