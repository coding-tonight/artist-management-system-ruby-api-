module MusicConcern
  extend ActiveSupport::Concern

  def music_data
    @data =  Music.group(:genre).count
    puts @data.keys()
  end
end
